# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )
DISTUTILS_USE_SETUPTOOLS=pyproject.toml

inherit distutils-r1

DESCRIPTION="CMake LSP Implementation "
HOMEPAGE="https://pypi.org/project/cmake-language-server/ https://github.com/regen100/cmake-language-server"
SRC_URI="https://github.com/regen100/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/pygls-0.11[${PYTHON_USEDEP}]
	<dev-python/pygls-0.12[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-datadir[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests --install pytest
