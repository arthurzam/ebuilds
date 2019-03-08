# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGIT_REPO_URI="https://github.com/Tomas-M/iotop"
inherit git-r3

DESCRIPTION="top utility for IO (C port)"
HOMEPAGE="https://github.com/Tomas-M/iotop"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="sys-libs/ncurses
	!sys-process/iotop"
DEPEND="${RDEPEND}"

src_install() {
	dobin iotop
	dodoc README.md
}
