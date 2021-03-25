# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A full-featured & carefully designed adaptive prompt for Bash & Zsh"
HOMEPAGE="https://github.com/nojhan/liquidprompt"
SRC_URI="https://github.com/nojhan/liquidprompt/releases/download/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( CHANGELOG.md example.bashrc README.md )

S="${WORKDIR}/${PN}"

src_install() {
	default
	dobin liquidprompt

	insinto /usr/share/${PN}
	doins liquid.theme
	doins liquid.ps1
	doins -r themes

	insinto /etc/
	newins liquidpromptrc-dist liquidpromptrc
}
