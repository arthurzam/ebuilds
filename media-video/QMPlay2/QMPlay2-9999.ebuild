# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit user git-r3 cmake-utils

DESCRIPTION="QMPlay2 is a video player, it can plays all formats and stream"
HOMEPAGE="http://qt-apps.org/content/show.php/QMPlay2?content=153339"
EGIT_REPO_URI="https://github.com/zaps166/QMPlay2.git"
LICENSE="LGPL"
SLOT="0"

L10N=" de es fr pl ru"
IUSE="+alsa -pulseaudio qt4 +qt5 gme libsidplay cdda +taglib debug portaudio prostopleer +xvideo +libass vaapi vdpau"
IUSE+="${L10N// / l10n_}"

COMMON_DEPENDS="
	qt4? (
        dev-qt/qtcore:4
	    dev-qt/qtgui:4
	    dev-qt/qtscript:4
		dev-qt/qtopengl:4
	)
	qt5? (
	    dev-qt/qtcore:5
	    dev-qt/qtgui:5
	    dev-qt/qtnetwork:5
	    dev-qt/qtscript:5
	    dev-qt/qtwidgets:5
		dev-qt/qtopengl:5
		dev-qt/qtx11extras:5
	)
	>=media-video/ffmpeg-2.2.0[libass?,vorbis(+),aac(+),openssl(+),gme?]
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
	portaudio? ( media-libs/portaudio )

	gme? ( media-libs/game-music-emu )
	libsidplay? ( media-libs/libsidplayfp )


	xvideo? ( x11-libs/libXv )
"
RDEPEND="${COMMON_DEPENDS}
	net-misc/youtube-dl 
	media-video/atomicparsley
"
	#media-video/rtmpdump
DEPENDS="${COMMON_DEPENDS}
	dev-qt/qtchooser
	dev-qt/linguist-tools
"

src_configure() {
	local langs x
	for x in ${L10N}; do
		use l10n_${x} && langs+=" ${x}"
	done

	local mycmakeargs=(
		-DLANGUAGES="${langs}"
		-DUSE_QT5=$(usex qt5)
		-DUSE_CHIPTUNE_GME=$(usex gme)
		-DUSE_CHIPTUNE_SID=$(usex libsidplay)
		-DUSE_AUDIOCD=$(usex cdda)
		-DUSE_PULSEAUDIO=$(usex pulseaudio)
		-DUSE_PORTAUDIO=$(usex portaudio)
		-DUSE_PROSTOPLEER=$(usex prostopleer)
		-DUSE_TAGLIB=$(usex taglib)
		-DUSE_LIBASS=$(usex libass)
		-DUSE_FFMPEG_VAAPI=$(usex vaapi)
		-DUSE_FFMPEG_VDPAU=$(usex vdpau)
		-DUSE_XVIDEO=$(usex xvideo)
	)
	use !debug && append-cppflags -DQT_NO_DEBUG_OUTPUT
	cmake-utils_src_configure
}
