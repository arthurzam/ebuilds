# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="generates a status bar for dzen2, xmobar or similar"
HOMEPAGE="http://i3wm.org/i3status/"
EGIT_REPO_URI="https://github.com/arthurzam/i3status"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/confuse
	dev-libs/libnl:3
	>=dev-libs/yajl-2.0.2
	media-libs/alsa-lib
	"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

