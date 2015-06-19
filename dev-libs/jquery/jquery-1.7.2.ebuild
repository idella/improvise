# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2:2.6"
inherit base

DESCRIPTION="A set of query functions in javascript"
HOMEPAGE="http://code.jquery.com/"
SRC_URI="http://code.jquery.com/${P}.js http://code.jquery.com/${P}.min.js"

LICENSE="MIT GPL-2"
SLOT="0"

KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
S=${WORKDIR}

src_unpack() {
	cp $DISTDIR/jquery-1.7.2.js $DISTDIR/jquery-1.7.2.min.js ${WORKDIR}
}

src_install() {
	insinto /usr/share/${PN}/${PV}/
	doins ${P}.js ${P}.min.js
}
