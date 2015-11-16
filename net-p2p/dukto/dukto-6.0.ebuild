# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils gnome2-utils qmake-utils

DESCRIPTION="A simple, fast and multi-platform file transfer tool for LAN users."
HOMEPAGE="http://www.msec.it/dukto"

SRC_URI="http://download.opensuse.org/repositories/home:/colomboem/xUbuntu_15.04/${P}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

REQUIRED_USE=""

DEPEND="
   	dev-qt/qtcore:4
    dev-qt/qtdeclarative:4
   	dev-qt/qtgui:4
   	dev-qt/qtscript:4
   	dev-qt/qtsingleapplication[X,qt4]
    dev-qt/qtsql:4
   	dev-qt/qtsvg:4
   	dev-qt/qtxmlpatterns:4
    "
src_configure() {
    eqmake4
}

src_install() {
	exeinto /usr/bin
	doexe ${S}/${PN}
	
	domenu ${PN}.desktop
	
	doicon ${PN}.png
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

