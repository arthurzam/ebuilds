# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Implementation of the Language Server Protocol for Python"
HOMEPAGE="https://github.com/palantir/python-language-server https://pypi.org/project/python-language-server/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="autopep8 +yapf"

RDEPEND="
	dev-python/flake8[${PYTHON_USEDEP}]
	>=dev-python/jedi-0.14.1[${PYTHON_USEDEP}]
	<dev-python/jedi-0.16[${PYTHON_USEDEP}]
	dev-python/mccabe[${PYTHON_USEDEP}]
	dev-python/pluggy[${PYTHON_USEDEP}]
	dev-python/pycodestyle[${PYTHON_USEDEP}]
	dev-python/pydocstyle[${PYTHON_USEDEP}]
	>=dev-python/pyflakes-1.6.0[${PYTHON_USEDEP}]
	dev-python/pylint[${PYTHON_USEDEP}]
	>=dev-python/python-jsonrpc-server-0.3.2[${PYTHON_USEDEP}]
	>dev-python/rope-0.10.5[${PYTHON_USEDEP}]
	<=dev-python/ujson-1.35[${PYTHON_USEDEP}]
	autopep8? ( dev-python/autopep8[${PYTHON_USEDEP}] )
	yapf? ( dev-python/yapf[${PYTHON_USEDEP}] )
"
