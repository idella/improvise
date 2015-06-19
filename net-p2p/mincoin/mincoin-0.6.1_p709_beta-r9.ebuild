# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

EAPI=5

DB_VER="4.8"

inherit bash-completion-r1 db-use eutils systemd git-2 user

MyPV="${PV/_/-}"
MyPN="mincoin"
MyP="${MyPN}-${MyPV}"

DESCRIPTION="P2P Internet currency based on Bitcoin but easier to mine."
HOMEPAGE="http://mincoinforum.com/"
HOMEPAGE="http://www.min-coin.org/"
#SRC_URI="https://github.com/${MyPN}-project/${MyPN}/archive/v${MyPV}.tar.gz -> ${MyP}.tar.gz"
EGIT_REPO_URI="https://github.com/vipah/mincoin.git"
EGIT_HAS_SUBMODULES=1

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion examples ipv6 logrotate upnp"

RDEPEND="
        dev-libs/boost[threads(+)]
        dev-libs/openssl:0[-bindist]
        logrotate? (
                app-admin/logrotate
        )
        upnp? (
                <=net-libs/miniupnpc-1.7
        )
        sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
        <=dev-libs/leveldb-1.14.0
"
DEPEND="${RDEPEND}
        >=app-shells/bash-4.1
        sys-apps/sed
"

S="${WORKDIR}/${MyP}"

pkg_setup() {
        local UG='mincoin'
        enewgroup "${UG}"
        enewuser "${UG}" -1 -1 /var/lib/mincoin "${UG}"
}

src_prepare() {
#	epatch "${FILESDIR}"/${MyPN}-MAX_OUTBOUND_CONNECTIONS.patch
#	epatch "${FILESDIR}"/${MyPN}-NO_DEBUGFLAGS_O3.patch
        #epatch "${FILESDIR}"/${MyPN}-NODEBUG_NOIPV6.patch
#        epatch "${FILESDIR}"/${MyPN}-CheckDiskSpace.patch
        #epatch "${FILESDIR}"/${MyPN}-sys_leveldb.patch
        #rm -r src/leveldb

        if has_version '>=dev-libs/boost-1.52'; then
                sed -i 's/\(-l db_cxx\)/-l boost_chrono$(BOOST_LIB_SUFFIX) \1/' src/makefile.unix
        fi
}

src_configure() {
        OPTS=()

        #OPTS+=("DEBUGFLAGS=")
        OPTS+=("CXXFLAGS=${CXXFLAGS}")
        OPTS+=("LDFLAGS=${LDFLAGS}")

        if use upnp; then
                OPTS+=("USE_UPNP=1")
        else
                OPTS+=("USE_UPNP=-")
        fi

        use ipv6 || OPTS+=("USE_IPV6=-")

        OPTS+=("USE_SYSTEM_LEVELDB=1")
        OPTS+=("BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")")
        OPTS+=("BDB_LIB_SUFFIX=-${DB_VER}")

        cd src || die
        emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" -f makefile.unix "${OPTS[@]}" ${MyPN}
}

#Tests are broken with and without our litecoin-sys_leveldb.patch.
#When tests work, make sure to inherit toolchain-funcs
#src_test() {
#       cd src || die
#       emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" -f makefile.unix "${OPTS[@]}" test_litecoin
#       ./test_litecoin || die 'Tests failed'
#}

src_install() {
        dobin src/${MyPN}

        insinto /etc/mincoin
        doins "${FILESDIR}/mincoin.conf"
        fowners mincoin:mincoin /etc/mincoin/mincoin.conf
        fperms 600 /etc/mincoin/mincoin.conf

        newconfd "${FILESDIR}/mincoin.confd" ${PN}
        newinitd "${FILESDIR}/mincoin.initd" ${PN}
        systemd_dounit "${FILESDIR}/mincoin.service"

        keepdir /var/lib/mincoin/.mincoin
        fperms 700 /var/lib/mincoin
        fowners mincoin:mincoin /var/lib/mincoin/
        fowners mincoin:mincoin /var/lib/mincoin/.mincoin
        dosym /etc/mincoin/mincoin.conf /var/lib/mincoin/.mincoin/mincoin.conf
        dosym /var/log/mincoin.log /var/lib/mincoin/.mincoin/debug.log

        dodoc doc/README # doc/release-notes.md
        newman contrib/debian/manpages/bitcoind.1 mincoin.1
        newman contrib/debian/manpages/bitcoin.conf.5 mincoin.conf.5

        if use bash-completion; then
                newbashcomp contrib/bitcoind.bash-completion ${PN}.bash-completion
        fi

        if use examples; then
                docinto examples
                dodoc -r contrib/{bitrpc,pyminer,wallettools}
        fi

        if use logrotate; then
                insinto /etc/logrotate.d
                newins "${FILESDIR}/mincoin.logrotate" mincoin
        fi
}

