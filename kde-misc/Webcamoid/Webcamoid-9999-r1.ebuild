# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://github.com/hipersayanX/Webcamoid"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
inherit git-2 python
#distutils

DESCRIPTION="A plasmoid used to show and take photos with your webcam"
HOMEPAGE="http://kde-apps.org/content/show.php/Webcamoid?content=144796"
LICENSE="GPL-3"
INSTALLDIR="usr/share/apps/plasma/plasmoids/webcamoid/code"

SLOT="4"
KEYWORDS=""
IUSE=""

DEPEND="kde-base/pykde4
	kde-base/kdepimlibs
	kde-base/libkworkspace"
RDEPEND="${DEPEND} media-video/ffmpeg
	kde-base/plasma-runtime"

src_unpack() {
	git-2_src_unpack
	cd ${S}
	cp "${FILESDIR}"/setup.py "${FILESDIR}"/setup.cfg .
	mv contents webcamoid
	touch webcamoid/code/__init__.py webcamoid/__init__.py
	mv webcamoid/code/v4l2 .
}

src_prepare() {
	python_copy_sources
}

src_compile() {
	:
}

src_install() {
	installation() {
		cd v4l2
		$(PYTHON) setup.py install --prefix="${D}usr"
		insinto usr/$(get_libdir)/python$(python_get_version)/site-packages/v4l2
	        doins *.py
		cd ../
		$(PYTHON) setup.py install --install-purelib="${D}${INSTALLDIR}"
	}
	python_execute_function -s installation

	dobin webcamoid/code/v4l2tools.py

	insinto usr/share/kde4/services
	newins metadata.desktop webcamoid.desktop

	insinto ${INSTALLDIR}
	doins webcamoid/code/{config.py,__init__.py,main.py,webcamoidgui.py}
	insinto usr/share/apps/plasma/plasmoids/webcamoid/
	doins webcamoid/__init__.py

	insinto usr/share/doc/${P}/v4l2
	doins v4l2/{NEWS,README}

	insinto usr/share/doc/${P}
	newins README.markdown README
}

postrm() {
	python_mod_optimize v4l2
	python_mod_optimize usr/share/apps/plasma/plasmoids/webcamoid
}

postinst() {
	python_mod_optimize v4l2
	python_mod_optimize usr/share/apps/plasma/plasmoids/webcamoid
}
