# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Asynchronous JSON RPC server "
HOMEPAGE="https://github.com/palantir/python-jsonrpc-server https://pypi.org/project/python-jsonrpc-server/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/future[${PYTHON_USEDEP}]
	<=dev-python/ujson-1.35[${PYTHON_USEDEP}]
"
