# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

if [[ "${PV}" == "9999" ]]; then
	inherit mercurial
	EHG_REPO_URI="https://bitbucket.org/hpk42/pytest-xdist"
	SRC_URI=""
else
  SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
fi

DESCRIPTION="A distributed testing plugin for py.test"
HOMEPAGE="https://bitbucket.org/hpk42/pytest-xdist https://pypi.python.org/pypi/pytest-xdist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-python/pytest-2.4.2[${PYTHON_USEDEP}]
	>=dev-python/py-1.4.22[${PYTHON_USEDEP}]
	>=dev-python/execnet-1.1[${PYTHON_USEDEP}]"
DEPEND="
	test? ( ${RDEPEND} )"

python_test() {
	distutils_install_for_testing
	rsync -av "${BUILD_DIR}/pytest_xdist.egg-info/" "${TEST_DIR}/lib/pytest_xdist-1.11-py2.7.egg/EGG-INFO/"
	py.test || die "Testsuite failed under ${EPYTHON}"
#	py.test testing
}
