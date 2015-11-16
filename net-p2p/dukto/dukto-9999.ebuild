# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils gnome2-utils cmake-utils

DESCRIPTION="A simple, fast and multi-platform file transfer tool for LAN users."
HOMEPAGE="http://www.msec.it/dukto"

if [[ ${PV} == *9999* ]] ; then
    inherit git-2
    EGIT_REPO_URI="https://github.com/arthurzam/dukto-qt5.git"
else
    SRC_URI="http://download.opensuse.org/repositories/home:/colomboem/xUbuntu_15.04/${P}_${PV}.orig.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+qt4 qt5 unique"

REQUIRED_USE="^^ ( qt4 qt5 )"

DEPEND="
    qt4? (
    	dev-qt/qtcore:4
	    dev-qt/qtdeclarative:4
    	dev-qt/qtgui:4
    	dev-qt/qtscript:4
    	dev-qt/qtsingleapplication[X,qt4]
	    dev-qt/qtsql:4
    	dev-qt/qtsvg:4
    	dev-qt/qtxmlpatterns:4
    )
    qt5? (
        dev-qt/qtcore:5
        dev-qt/qtgui:5
        dev-qt/qtnetwork:5
        dev-qt/qtquick1:5
        dev-qt/qtscript:5
        dev-qt/qtsql:5
        dev-qt/qtwidgets:5
    )
    "
src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use qt5)
		$(cmake-utils_use_use unique SINGLE_APP)
		-DUSE_UPDATER=OFF
	)
	cmake-utils_src_configure
}


pkg_postinst() {
	gnome2_icon_cache_update	
}

pkg_postrm() {
	gnome2_icon_cache_update
}

