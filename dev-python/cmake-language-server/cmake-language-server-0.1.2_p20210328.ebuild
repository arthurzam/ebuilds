# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=pyproject.toml

inherit distutils-r1

COMMIT=a5af5b505f8810760168dc250caf8404370b15c3

DESCRIPTION="CMake LSP Implementation "
HOMEPAGE="https://pypi.org/project/cmake-language-server/ https://github.com/regen100/cmake-language-server"
SRC_URI="https://github.com/regen100/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/pygls-0.10[${PYTHON_USEDEP}]
	<dev-python/pygls-0.11[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
"
