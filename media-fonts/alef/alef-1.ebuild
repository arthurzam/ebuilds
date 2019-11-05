# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

DESCRIPTION="Hebrew open source multiscript font"
HOMEPAGE="http://alef.hagilda.com/"
SRC_URI="http://alef.hagilda.com/Alef.zip"

LICENSE="OFL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="binchecks strip test"

BDEPEND="app-arch/unzip"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}/TTF"
DOCS=( "readme.txt" )
