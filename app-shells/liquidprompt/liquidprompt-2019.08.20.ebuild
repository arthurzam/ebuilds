# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_COMMIT="5f4aeece8d6cf98138e729f7833e11e985ca44d3"

DESCRIPTION="A full-featured & carefully designed adaptive prompt for Bash & Zsh"
HOMEPAGE="https://github.com/nojhan/liquidprompt"
SRC_URI="https://github.com/nojhan/liquidprompt/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( example.bashrc CHANGES README.md )

S="${WORKDIR}/liquidprompt-${MY_COMMIT}"

src_install() {
	default
	dobin liquidprompt

	insinto /usr/share/${PN}
	doins liquid.theme
	doins liquid.ps1

	insinto /etc/
	newins liquidpromptrc-dist liquidpromptrc
}
