# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="generates a status bar for dzen2, xmobar or similar"
HOMEPAGE="http://i3wm.org/i3status/"
EGIT_REPO_URI="https://github.com/arthurzam/i3status"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static"

RDEPEND="
	!static? (
		dev-libs/confuse
		dev-libs/libnl:3
	)
	>=dev-libs/yajl-2.0.2
	media-libs/alsa-lib
"
DEPEND="
	${RDEPEND}
	static? (
		dev-libs/confuse[static-libs(+)]
		dev-libs/libnl:3[static-libs(+)]
	)
"
BDEPEND="virtual/pkgconfig"

src_configure() {
	use_if_iuse static && local mycmakeargs=(
		-DLIBCONFUSE_LIBRARIES=/usr/lib/libconfuse.a
		-DLIBNL_LIBRARIES="/usr/lib/libnl-3.a;/usr/lib/libnl-genl-3.a"
	)
	append-cppflags -fvisibility=hidden
	cmake-utils_src_configure
}
