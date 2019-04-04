# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user git-r3 cmake-utils xdg-utils

DESCRIPTION="QMPlay2 is a video player, it can plays all formats and stream"
HOMEPAGE="http://qt-apps.org/content/show.php/QMPlay2?content=153339"
EGIT_REPO_URI="https://github.com/zaps166/QMPlay2.git"
LICENSE="LGPL-3"
SLOT="0"

L10N=" de es fr pl ru"
IUSE="+alsa -pulseaudio cuda gme libsidplay cdda +taglib debug portaudio +lastfm xvideo +libass vaapi vdpau modplug +dbus"
IUSE+="${L10N// / l10n_}"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtopengl:5
	dbus? ( dev-qt/qtdbus:5 )
	media-video/ffmpeg[libass?,vorbis(+),aac(+),openssl(+),gme?,librtmp(+)]
	libass? ( media-libs/libass )
	vaapi? ( x11-libs/libva[X,vdpau?] )
	vdpau? ( x11-libs/libvdpau )
	cdda? (
		media-libs/libcddb
		dev-libs/libcdio
	)
	pulseaudio? ( media-sound/pulseaudio )
	alsa? ( media-libs/alsa-lib )
	taglib? ( media-libs/taglib )
	cuda? ( dev-util/nvidia-cuda-sdk )
	portaudio? ( media-libs/portaudio )
	gme? ( media-libs/game-music-emu )
	libsidplay? ( media-libs/libsidplayfp )
	xvideo? ( x11-libs/libXv )
"
RDEPEND="${DEPEND}
	net-misc/youtube-dl
"
BDEPENDS="
	dev-qt/linguist-tools
	virtual/pkgconfig
"

src_configure() {
	local langs x
	for x in ${L10N}; do
		use l10n_${x} && langs+=" ${x}"
	done

	local mycmakeargs=(
		-DLANGUAGES="${langs}"
		-DUSE_AUDIOCD=$(usex cdda)
		-DUSE_CHIPTUNE_GME=$(usex gme)
		-DUSE_CHIPTUNE_SID=$(usex libsidplay)
		-DUSE_CUVID=$(usex cuda)
		-DUSE_FFMPEG_VAAPI=$(usex vaapi)
		-DUSE_FFMPEG_VDPAU=$(usex vdpau)
		-DUSE_LASTFM=$(usex lastfm)
		-DUSE_LIBASS=$(usex libass)
		-DUSE_MODPLUG=$(usex modplug)
		-DUSE_MPRIS2=$(usex dbus)
		-DUSE_PORTAUDIO=$(usex portaudio)
		-DUSE_PULSEAUDIO=$(usex pulseaudio)
		-DUSE_TAGLIB=$(usex taglib)
		-DUSE_XVIDEO=$(usex xvideo)
	)
	use !debug && append-cppflags -DQT_NO_DEBUG_OUTPUT
	cmake-utils_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}
