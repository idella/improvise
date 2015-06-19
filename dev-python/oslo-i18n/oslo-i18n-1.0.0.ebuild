# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/oslo-config/oslo-config-1.4.0.ebuild,v 1.3 2014/09/27 20:09:28 alunduil Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 )

inherit distutils-r1

MY_PN="oslo.i18n"
DESCRIPTION="Oslo i18n library"
HOMEPAGE="https://launchpad.net/oslo"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~x86 ~x86-linux"
IUSE="doc test"
RESTRICT="test"		# suite doesn't work out of the box and fail tests when from tox anyway

COMMON_DEPEND="
		>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
		!~dev-python/sphinx-1.2.0[${PYTHON_USEDEP}]
		<dev-python/sphinx-1.3[${PYTHON_USEDEP}]
		>=dev-python/oslo-sphinx-2.2.0[${PYTHON_USEDEP}]"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pbr[${PYTHON_USEDEP}]
	test? (
		<dev-python/hacking-0.10[${PYTHON_USEDEP}]
		>=dev-python/hacking-0.9.2[${PYTHON_USEDEP}]
		${COMMON_DEPEND}
		>=dev-python/oslotest-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}] )
	doc? ( ${COMMON_DEPEND} )"
RDEPEND="
	>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
	>=dev-python/six-1.7.0[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_PN}-${PV}"

python_compile_all() {
	use doc && "${PYTHON}" setup.py build_sphinx
}

python_test() {
	testr init || die "testr init failed"
	PYTHONPATH=. testr run || die "testr run failed under ${EPYTHON}"
}

python_install_all() {
	if use doc; then
		local HTML_DOCS=( doc/build/html/. )
		doman doc/build/man/osloi18n.1
	fi
	distutils-r1_python_install_all
}
