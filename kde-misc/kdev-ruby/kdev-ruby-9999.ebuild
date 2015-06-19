# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
KDE_SCM="git"
EGIT_REPO_URI="git://anongit.kde.org/kdev-ruby"
inherit kde4-base

DESCRIPTION="A ruby plugin for kde"
HOMEPAGE="https://projects.kde.org/projects/playground/devtools/plugins/kdev-ruby/"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-util/kdevplatform
	dev-lang/ruby"
RDEPEND="${DEPEND}"

RESTRICT="test"

src_install() {
	kde4-base_src_install
	rm -rf ${ED}mnt/

	if use doc; then
		if [ -e /usr/include/ruby-1.9.1/ruby/version.h ]; then
			cp /usr/include/ruby-1.9.1/ruby/version.h documentation || die
		elif [ -e /usr/include/ruby-1.8/ruby/version.h ]; then
			cp /usr/include/ruby-1.8/ruby/version.h documentation || die
		fi
		cd documentation
		ruby kdevruby_doc.rb ./ ruby-docs.txt
		elog "Documentation successfully generated into file ruby-docs.txt"
		docompress -x usr/share/doc/${P}/
		insinto usr/share/doc/${P}/
		doins ruby-docs.txt
	fi
}
