# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGIT_REPO_URI="https://github.com/clementine-player/Clementine.git"

LANGS=" af ar be bg bn br bs ca cs cy da de el en_CA en_GB eo es es_AR et eu fa fi fr ga gl he hi hr hu hy ia id is it ja ka kk ko lt lv mr ms nb nl oc pa pl pt pt_BR ro ru sk sl sr sr@latin sv te tr uk uz vi zh_CN zh_TW"

inherit cmake-utils flag-o-matic fdo-mime gnome2-utils virtualx
[[ ${PV} == *9999* ]] && inherit git-r3

DESCRIPTION="A modern music player and library organizer based on Amarok 1.4 and Qt4"
HOMEPAGE="http://www.clementine-player.org https://github.com/clementine-player/Clementine"
[[ ${PV} == *9999* ]] || \
SRC_URI="https://github.com/clementine-player/Clementine/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
[[ ${PV} == *9999* ]] || \
KEYWORDS="~amd64 ~x86"
IUSE="+qt4 qt5 ayatana box cdda +dbus debug dropbox googledrive ipod lastfm mms moodbar mtp projectm skydrive system-sqlite test ubuntu-one +udisks wiimote sparkle sealife pulseaudio amazon vk"
IUSE+="${LANGS// / linguas_}"

REQUIRED_USE="
	^^ ( qt4 qt5 )
	udisks? ( dbus )
	wiimote? ( dbus )
"

COMMON_DEPEND="
	qt5? (
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtx11extras:5
		dev-qt/qtsql:5[sqlite]
		dev-qt/qtopengl:5
		dbus? ( dev-qt/qtdbus:5 )
		>=media-libs/libmygpo-qt-1.0.7[qt5]
		media-libs/libechonest[qt5]
	)
	qt4? (
		dev-libs/qjson
		>=dev-qt/qtsql-4.5:4[sqlite]
		>=dev-qt/qtgui-4.5:4
		>=dev-qt/qtopengl-4.5:4
		dbus? ( >=dev-qt/qtdbus-4.5:4 )
		>=media-libs/libmygpo-qt-1.0.7[qt4]
		media-libs/libechonest[qt4]
	)
	
	system-sqlite? ( dev-db/sqlite[fts3(+)] )
	>=media-libs/taglib-1.8[mp4(+)]
	>=dev-libs/glib-2.24.1-r1
	dev-libs/libxml2
	dev-libs/protobuf:=
	>=media-libs/chromaprint-0.6
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	dev-libs/crypto++
	virtual/glu
	virtual/opengl
	ayatana? ( dev-libs/libindicate-qt )
	cdda? ( dev-libs/libcdio )
	ipod? ( >=media-libs/libgpod-0.8.0 )
	lastfm? ( >=media-libs/liblastfm-1[qt4(+)] )
	mtp? ( >=media-libs/libmtp-1.0.0 )
	moodbar? ( sci-libs/fftw:3.0 )
	projectm? ( media-libs/glew )
"
# now only presets are used, libprojectm is internal
# https://github.com/clementine-player/Clementine/tree/master/3rdparty/libprojectm/patches
# r1966 "Compile with a static sqlite by default, since Qt 4.7 doesn't seem to expose the symbols we need to use FTS"
RDEPEND="${COMMON_DEPEND}
	dbus? ( udisks? ( sys-fs/udisks:0 ) )
	mms? ( media-plugins/gst-plugins-libmms:0.10 )
	mtp? ( gnome-base/gvfs )
	projectm? ( >=media-libs/libprojectm-1.2.0 )
	
	media-plugins/gst-plugins-meta:1.0
	media-plugins/gst-plugins-soup:1.0
	media-plugins/gst-plugins-taglib:1.0
"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/boost-1.39
	virtual/pkgconfig
	sys-devel/gettext
	qt5? ( dev-qt/qttest:5 )
	qt4? ( dev-qt/qttest:4 )
	dev-cpp/gmock
	box? ( dev-cpp/sparsehash )
	dropbox? ( dev-cpp/sparsehash )
	googledrive? ( dev-cpp/sparsehash )
	skydrive? ( dev-cpp/sparsehash )
	ubuntu-one? ( dev-cpp/sparsehash )
	test? ( gnome-base/gsettings-desktop-schemas )
"
DOCS="Changelog"

# https://github.com/clementine-player/Clementine/issues/3935
RESTRICT="test"

# Switch to ^ when we switch to EAPI=6.
[[ ${PV} == *9999* ]] || \
S="${WORKDIR}/C${P:1}"
PATCHES=(
	"${FILESDIR}"/fts.patch
)

src_unpack() {
	use qt5 && EGIT_BRANCH="qt5"
	git-r3_src_unpack
}

src_prepare() {
	cmake-utils_src_prepare

	# some tests fail or hang
	sed -i \
		-e '/add_test_file(translations_test.cpp/d' \
		tests/CMakeLists.txt || die
}

src_configure() {
	local langs x
	for x in ${LANGS}; do
		use linguas_${x} && langs+=" ${x}"
	done

	# spotify is not in portage
	local mycmakeargs=(
		-DBUILD_WERROR=OFF
		-DLINGUAS="${langs}"
		-DBUNDLE_PROJECTM_PRESETS=OFF
		-DENABLE_AUDIOCD=$(usex cdda)
		-DENABLE_DBUS=$(usex dbus)
		-DENABLE_DEVICEKIT=$(usex udisks)
		-DENABLE_LIBGPOD=$(usex ipod)
		-DENABLE_LIBLASTFM=$(usex lastfm)
		-DENABLE_LIBMTP=$(usex mtp)
		-DENABLE_MOODBAR=$(usex moodbar)
		-DENABLE_GIO=ON
		-DENABLE_WIIMOTEDEV=$(usex wiimote)
		-DENABLE_VISUALISATIONS=$(usex projectm)
		-DENABLE_SOUNDMENU=$(usex ayatana)
		-DENABLE_BOX=$(usex box)
		-DENABLE_DROPBOX=$(usex dropbox)
		-DENABLE_GOOGLE_DRIVE=$(usex googledrive)
		-DENABLE_SKYDRIVE=$(usex skydrive)
		-DENABLE_UBUNTU_ONE=$(usex ubuntu-one)
		-DENABLE_AMAZON_CLOUD_DRIVE=$(usex amazon)
		-DENABLE_VK=$(usex vk)
		-DENABLE_SPOTIFY_BLOB=OFF
		-DENABLE_BREAKPAD=OFF
		-DENABLE_SPARKLE=$(usex sparkle)
		-DENABLE_SEAFILE=$(usex sealife)
		-DENABLE_LIBPULSE=$(usex pulseaudio)
		-DSTATIC_SQLITE=$(usex !system-sqlite)
		-DI_HATE_MY_USERS=$(usex system-sqlite)
		-DMY_USERS_WILL_SUFFER_BECAUSE_OF_ME=$(usex system-sqlite)
		-DUSE_BUILTIN_TAGLIB=OFF
		-DUSE_SYSTEM_GMOCK=ON
		# force to find crypto++ see bug #548544
		-DCRYPTOPP_LIBRARIES="crypto++"
		-DCRYPTOPP_FOUND=ON
		)

	use !debug && append-cppflags -DQT_NO_DEBUG_OUTPUT

	cmake-utils_src_configure
}

src_test() {
	cd "${CMAKE_BUILD_DIR}" || die
	Xemake test
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
