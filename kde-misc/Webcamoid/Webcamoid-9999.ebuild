# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
EGIT_REPO_URI="git://github.com/hipersayanX/Webcamoid"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
inherit git-2 distutils

DESCRIPTION="A plasmoid used to show and take photos with your webcam"
HOMEPAGE="http://kde-apps.org/content/show.php/Webcamoid?content=144796"
LICENSE="GPL-2"
INSTALLDIR="usr/share/apps/plasma/plasmoids/webcamoid/contents/code"

SLOT="4"
KEYWORDS=""
IUSE=""

DEPEND="kde-base/pykde4
	kde-base/kdepimlibs"
RDEPEND="${DEPEND} media-video/ffmpeg"

DISTUTILS_SETUP_FILES=("contents/code/v4l2|setup.py")
PYTHON_MODNAME="v4l2.py webcamoid"

src_unpack() {
	git-2_src_unpack
	cd ${S}
	cp "${FILESDIR}"/setup.py "${FILESDIR}"/setup.cfg .
	cp "${FILESDIR}"/setup2.cfg contents/code/v4l2/
	touch contents/code/__init__.py
}

src_prepare() {
	python_copy_sources
}

src_install() {
	installation() {
		d contents/code/v4l2
		$(PYTHON) setup.py install --prefix="${D}usr"
		insinto usr/$(get_libdir)/python$(python_get_version)/site-packages/v4l2
		doins *.py
		$(PYTHON) setup.py install --install-purelib="${D}${INSTALLDIR}/v4l2"
		insinto ${INSTALLDIR}/v4l2
		doins *.py

		 cd ../../../
		$(PYTHON) setup.py install --install-purelib="${D}${INSTALLDIR}"
	}
	python_execute_function -s installation

	dobin contents/code/v4l2tools.py

	insinto usr/share/kde4/services
	newins metadata.desktop webcamoid.plasmoid
	doins metadata.desktop

	insinto ${INSTALLDIR}
	doins contents/code/{config.py,__init__.py,main.py,webcamoidgui.py}
	insinto usr/share/apps/plasma/plasmoids/webcamoid/contents
	insinto usr/share/apps/plasma/plasmoids/webcamoid/
	doins metadata.desktop
	newins metadata.desktop webcamoid.plasmoid

	dodoc contents/code/v4l2/{NEWS,README}
	insinto usr/share/doc/${P}
	newins README.markdown README
}
