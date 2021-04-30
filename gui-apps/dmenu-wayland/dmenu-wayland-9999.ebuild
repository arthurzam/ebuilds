# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="dmenu for wayland-compositors"
HOMEPAGE="https://github.com/nyyManni/dmenu-wayland"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nyyManni/${PN}.git"
else
	SRC_URI="https://github.com/nyyManni/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-libs/wayland
	x11-libs/pango
	x11-libs/cairo
	x11-libs/libxkbcommon
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	virtual/pkgconfig
"
