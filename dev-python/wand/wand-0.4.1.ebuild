# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} pypy)

inherit distutils-r1

DESCRIPTION="Ctypes-based simple MagickWand API binding for Python"
HOMEPAGE="http://wand-py.org/"
SRC_URI="mirror://pypi/W/Wand/Wand-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-gfx/imagemagick"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/Wand-${PV}
