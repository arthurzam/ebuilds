# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Minimal Qt PolKit authentication agent"
HOMEPAGE="https://github.com/arthurzam/minimal-policykit-agent"

inherit git-r3
EGIT_REPO_URI="https://github.com/arthurzam/${PN}.git"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	sys-auth/polkit-qt[qt5(+)]
"
DEPEND="${RDEPEND}"
