# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

EGIT_REPO_URI="https://github.com/enkore/j4-dmenu-desktop"
inherit git-r3

DESCRIPTION="A rewrite of i3-dmenu-desktop, which is much faster"
HOMEPAGE="https://github.com/enkore/j4-dmenu-desktop"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	x11-misc/dmenu
"

src_configure() {
	local mycmakeargs=(
		-DWITH_TESTS=OFF
		-DWITH_GIT_CATCH=OFF
	)
	cmake-utils_src_configure
}
