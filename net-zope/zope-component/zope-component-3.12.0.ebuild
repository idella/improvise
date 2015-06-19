# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython *-pypy-*"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope Component Architecture"
HOMEPAGE="http://pypi.python.org/pypi/zope.component"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN/-//}"
S="${WORKDIR}/${MY_P}"

#RDEPEND="net-zope/namespaces-zope[zope]
#	net-zope/zodb
#	net-zope/zope-configuration
#	net-zope/zope-event
#	net-zope/zope-hookable
#	net-zope/zope-i18nmessageid
#	>=net-zope/zope-interface-3.8.0
#	net-zope/zope-proxy
#	net-zope/zope-schema
RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools"
PDEPEND="${DEPEND}"
#net-zope/zope-security"
