# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic git-r3

DESCRIPTION="generates a status bar for i3"
HOMEPAGE="https://github.com/arthurzam/is3-status"
EGIT_REPO_URI="https://github.com/arthurzam/is3-status"

LICENSE="GPL-3"
SLOT="0"
IUSE="+alsa +dbus man +sway X"

RDEPEND="
	dev-libs/yajl
	media-libs/alsa-lib
"
DEPEND="${RDEPEND}"
BDEPEND="man? ( app-text/scdoc )"

src_configure() {
	local mycmakeargs=(
		-DUSE_ALSA="$(usex alsa)"
		-DUSE_MAN="$(usex man)"
		-DUSE_MPRIS="$(usex dbus)"
		-DUSE_SWAYWM="$(usex sway)"
		-DUSE_X11="$(usex X)"

		-DUSE_BACKLIGHT=OFF
		-DUSE_BATTERY=OFF
		-DUSE_CPU_TEMP=OFF
		-DUSE_DISK_USAGE=OFF
		-DUSE_ETH=ON
		-DUSE_LOAD=OFF
		-DUSE_MEMORY=OFF
		-DUSE_RUN_WATCH=OFF
		-DUSE_SYSTEMD=OFF
	)
	append-cflags -fvisibility=hidden -fomit-frame-pointer -fno-exceptions -fno-asynchronous-unwind-tables -fno-unwind-tables
	cmake_src_configure
}
