# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-utils git-2

DESCRIPTION="Core library of PCManFM-Qt (Qt binding for libfm)"
HOMEPAGE="https://github.com/lxde/libfm-qt"
EGIT_REPO_URI="https://github.com/lxde/libfm-qt"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~arm ~x86"

DEPEND="
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtx11extras:5
	lxde-base/menu-cache
	x11-libs/libfm"
RDEPEND="${DEPEND}"
