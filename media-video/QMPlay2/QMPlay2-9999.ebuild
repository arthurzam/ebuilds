# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit user git-r3 cmake-utils

DESCRIPTION="QMPlay2 is a video player, it can plays all formats and stream"
HOMEPAGE="http://qt-apps.org/content/show.php/QMPlay2?content=153339"
EGIT_REPO_URI="https://github.com/zaps166/QMPlay2.git"
LICENSE="LGPL"
SLOT="0"

L10N=" de es fr pl ru"
IUSE="+alsa -pulseaudio qt4 +qt5 gme cdda +taglib debug portaudio prostopleer +xvideo +libass"
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
	x11-libs/libva[X,vdpau]
	cdda? (
		media-libs/libcddb
		dev-libs/libcdio
	)
	pulseaudio? ( media-sound/pulseaudio )
	alsa? ( media-libs/alsa-lib )
	taglib? ( media-libs/taglib )
	portaudio? ( media-libs/portaudio )

	gme? ( media-libs/game-music-emu )


	xvideo? ( x11-libs/libXv )
"
RDEPEND="${COMMON_DEPENDS}
	net-misc/youtube-dl 
	media-video/atomicparsley
"
	#media-libs/libsidplayfp
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
		$(cmake-utils_use_use qt5 QT5)
		$(cmake-utils_use_use gme CHIPTUNE_GME)
#		$(cmake-utils_use chiptune USE_CHIPTUNE_SID)
		$(cmake-utils_use_use cdda AUDIOCD)
		$(cmake-utils_use_use pulseaudio PULSEAUDIO)
		$(cmake-utils_use_use portaudio PORTAUDIO)
		$(cmake-utils_use_use prostopleer PROSTOPLEER)
		$(cmake-utils_use_use taglib TAGLIB)
		$(cmake-utils_use_use libass LIBASS)
		$(cmake-utils_use_use xvideo XVIDEO)
	)
	use !debug && append-cppflags -DQT_NO_DEBUG_OUTPUT
	cmake-utils_src_configure
}
