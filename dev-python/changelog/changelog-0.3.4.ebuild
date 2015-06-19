# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Provides simple Sphinx markup to render changelog displays"
HOMEPAGE=" http://bitbucket.org/zzzeek/changelog"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PF}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

#src_prepare () {
        # Avoid install of xstatic.pkg namespace to permit
        # setup of xstatic modules
        #sed -e 's/'\'xstatic.pkg\','//g' -i setup.py
        #rm xstatic/pkg/__init__.py
#}
