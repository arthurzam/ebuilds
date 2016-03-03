# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/enkore/j4-dmenu-desktop"
	inherit git-2
else
	SRC_URI="https://downloads.lxqt.org/lxqt/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A rewrite of i3-dmenu-desktop, which is much faster"
HOMEPAGE="https://github.com/enkore/j4-dmenu-desktop"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	x11-misc/dmenu
"

src_configure() {
	local mycmakeargs=(
		-DNO_TESTS=1
	)
	cmake-utils_src_configure
}
