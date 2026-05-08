# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Microsoft SEAL homomorphic encryption library"
HOMEPAGE="https://github.com/microsoft/SEAL https://www.microsoft.com/en-us/research/project/microsoft-seal/"
SRC_URI="https://github.com/microsoft/SEAL/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/SEAL-${PV}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="examples test zlib zstd"
RESTRICT="!test? ( test )"

DEPEND="
	dev-cpp/ms-gsl
	zlib? ( virtual/zlib )
	zstd? ( app-arch/zstd )
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	test? ( dev-cpp/gtest )
"

src_configure() {
	local mycmakeargs=(
		# Use Gentoo/system dependencies. Do not let upstream fetch vendored deps.
		-DSEAL_BUILD_DEPS=OFF

		# Required by request: use system Microsoft GSL.
		-DSEAL_USE_MSGSL=ON

		# Build shared library for normal distro packaging.
		-DBUILD_SHARED_LIBS=ON

		# Modern SEAL benefits from / supports C++17.
		-DSEAL_USE_CXX17=ON

		# Avoid extra components by default.
		-DSEAL_BUILD_EXAMPLES=$(usex examples)
		-DSEAL_BUILD_TESTS=$(usex test)
		-DSEAL_BUILD_BENCH=OFF
		-DSEAL_BUILD_SEAL_C=OFF

		# Optional compression support.
		-DSEAL_USE_ZLIB=$(usex zlib)
		-DSEAL_USE_ZSTD=$(usex zstd)

		# Optional CPU-kernel dependency not packaged here.
		-DSEAL_USE_INTEL_HEXL=OFF

		-DSEAL_USE_INTRIN=ON
	)

	cmake_src_configure
}
