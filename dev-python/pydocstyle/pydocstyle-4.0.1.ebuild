# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Docstring style checker"
HOMEPAGE="https://github.com/PyCQA/pydocstyle https://pypi.org/project/pydocstyle"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/snowballstemmer[${PYTHON_USEDEP}]"
BDEPDND="dev-python/setuptools[${PYTHON_USEDEP}]"
