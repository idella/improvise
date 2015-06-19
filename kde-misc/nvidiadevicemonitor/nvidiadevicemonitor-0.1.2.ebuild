# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

MY_PN="NVidiaDeviceMonitor"
DESCRIPTION="Displays card model, temperature and gpu\'s memory occupation"
HOMEPAGE="http://kde-apps.org/content/show.php/NVidia+Device+Monitor?content=148658"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/148658-${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"

SLOT="4"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} x11-drivers/nvidia-drivers"

S="${WORKDIR}/${MY_PN}"
