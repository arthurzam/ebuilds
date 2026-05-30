# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Build number is part of the upstream release URL but not of the version.
GB_BUILD=3047

RPM_COMPRESS_TYPE=zstd
inherit desktop rpm shell-completion xdg

DESCRIPTION="Git client for simultaneous branches on top of your existing workflow"
HOMEPAGE="https://gitbutler.com/"
SRC_URI="https://releases.gitbutler.com/releases/release/${PV}-${GB_BUILD}/linux/x86_64/GitButler-${PV}-1.x86_64.rpm"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

RDEPEND="
	virtual/zlib
	net-libs/libsoup:3.0
	net-libs/webkit-gtk:4.1
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3[wayland,X]
"

QA_PREBUILT="usr/bin/*"

src_compile() {
	ln -s "${S}/usr/bin/gitbutler-tauri" "${T}/but" || die
	"${T}/but" completions bash > "${T}/but.bash" || die
	"${T}/but" completions zsh > "${T}/_but" || die
	"${T}/but" completions fish > "${T}/but.fish" || die
}

src_install() {
	dobin usr/bin/gitbutler-tauri usr/bin/gitbutler-git-askpass
	dosym gitbutler-tauri /usr/bin/but

	newbashcomp "${T}/but.bash" but
	dozshcomp "${T}/_but"
	dofishcomp "${T}/but.fish"

	domenu usr/share/applications/GitButler.desktop

	insinto /usr/share/icons
	doins -r usr/share/icons/hicolor
}
