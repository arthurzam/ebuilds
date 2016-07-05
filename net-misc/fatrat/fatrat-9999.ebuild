# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="Qt5-based download/upload manager"
HOMEPAGE="http://fatrat.dolezel.info/"

EGIT_REPO_URI="https://github.com/LubosD/fatrat.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="bittorrent +curl doc xmpp nls webinterface"

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	bittorrent? ( >=net-libs/rb_libtorrent-0.14.5
			dev-qt/qtwebkit:5
			dev-qt/qtwebengine:5
			)
	curl? ( >=net-misc/curl-7.18.2 )
	doc? ( dev-qt/qthelp:5 )
	xmpp? ( net-libs/gloox )
	webinterface? ( dev-qt/qtscript:5 )"
DEPEND="${RDEPEND}
	>=dev-cpp/asio-1.1.0
	nls? ( sys-devel/gettext )"

src_configure() {
		local mycmakeargs="
			$(cmake-utils_use_with bittorrent) \
			$(cmake-utils_use_with curl) \
			$(cmake-utils_use_with doc DOCUMENTATION) \
			$(cmake-utils_use_with xmpp JABBER) \
			$(cmake-utils_use_with nls) \
			$(cmake-utils_use_with webinterface)"
		cmake-utils_src_configure
}

src_install() {
	use bittorrent && echo "MimeType=application/x-bittorrent;" >> "${S}"/data/${PN}.desktop
	cmake-utils_src_install
}

pkg_postinst() {
	# this is a completely optional and NOT automagic dep
	if ! has_version dev-libs/geoip; then
		elog "If you want the GeoIP support, then emerge dev-libs/geoip."
	fi
}
