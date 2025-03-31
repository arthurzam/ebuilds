# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C client for NATS"
HOMEPAGE="https://github.com/nats-io/nats.c"
SRC_URI="https://github.com/nats-io/nats.c/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/nats.c-${PV}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ssl sodium"

DEPEND="
	sodium? ( dev-libs/libsodium )
	ssl? ( dev-libs/openssl )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DNATS_BUILD_STREAMING=OFF
		-DNATS_BUILD_WITH_TLS=$(usex ssl)
		-DNATS_BUILD_USE_SODIUM=$(usex sodium)
	)
	cmake_src_configure
}
