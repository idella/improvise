# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2:2.6"
inherit python

DESCRIPTION="A C library with python bindings"
HOMEPAGE="https://launchpad.net/dee/"
SRC_URI="https://launchpad.net/dee/1.0/1.0.6/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="doc test examples"

DEPEND="dev-libs/glib:2
	dev-libs/icu"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/filter.patch
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc INSTALL README
	if use doc; then
		dohtml -r doc/reference/dee-1.0/html/
	fi

	if use examples; then
		docompress -x usr/share/doc/${PF}/examples
		cp -a examples ${ED}usr/share/doc/${PF}/
	fi
}
