# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

EGIT_REPO_URI="https://github.com/lxde/pcmanfm-qt"
inherit git-r3

DESCRIPTION="Fast lightweight tabbed filemanager (Qt port)"
HOMEPAGE="http://pcmanfm.sourceforge.net/"

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"

CDEPEND=">=dev-libs/glib-2.18:2
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	~x11-libs/libfm-qt-${PV}
	x11-libs/libxcb:=
"
RDEPEND="${CDEPEND}
	x11-misc/xdg-utils
	virtual/eject
	virtual/freedesktop-icon-theme"
DEPEND="${CDEPEND}
	dev-qt/linguist-tools:5
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig"
