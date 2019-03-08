# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{3_4,3_5,3_6} )
inherit distutils-r1

DESCRIPTION="CxxTest is a JUnit/CppUnit/xUnit-like unit testing framework for C++"
HOMEPAGE="http://cxxtest.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="examples doc"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
S="${S}/python"

src_install()
{
   distutils-r1_src_install
   cd "${WORKDIR}/${P}" || die
   insinto /usr/include/cxxtest
   doins cxxtest/*

   dodoc README Versions

   use doc && dodoc -r doc
   use examples && dodoc -r sample
}
