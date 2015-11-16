# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI="https://github.com/zrax/pycdc.git"

inherit cmake-utils
[[ ${PV} == *9999* ]] && inherit git-2

DESCRIPTION="C++ python bytecode disassembler and decompiler"
HOMEPAGE="https://github.com/zrax/pycdc"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-lang/python:*"
RDEPEND="${DEPEND}"
