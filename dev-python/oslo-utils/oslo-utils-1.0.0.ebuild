# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/oslo-config/oslo-config-1.4.0.ebuild,v 1.3 2014/09/27 20:09:28 alunduil Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 )

inherit distutils-r1

MY_PN="oslo.utils"
DESCRIPTION="Oslo Utility library"
HOMEPAGE="https://launchpad.net/oslo"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~x86 ~x86-linux"
IUSE="doc"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pbr[${PYTHON_USEDEP}]
	doc? ( >=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
		!~dev-python/sphinx-1.2.0[${PYTHON_USEDEP}]
		<dev-python/sphinx-1.3[${PYTHON_USEDEP}]
		>=dev-python/oslo-sphinx-2.2.0[${PYTHON_USEDEP}] )"
RDEPEND="
	>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
	>=dev-python/six-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/iso8601-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-0.2.0[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_PN}-${PV}"

# A testsuite is present but it's unable to be run because
# versions of some of its deps are currently unavailable.

python_compile_all() {
	use doc && "${PYTHON}" setup.py build_sphinx
}

python_install_all() {
	if use doc; then
		local HTML_DOCS=( doc/build/html/. )
		doman doc/build/man/osloutils.1
	fi

	distutils-r1_python_install_all
}
