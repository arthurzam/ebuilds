# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shell-completion

DESCRIPTION="Fast, disk space efficient package manager, alternative to npm and yarn"
HOMEPAGE="https://pnpm.io"
SRC_URI="
	amd64? ( https://github.com/pnpm/pnpm/releases/download/v${PV}/pnpm-linux-x64 -> ${P}-amd64 )
	arm64? ( https://github.com/pnpm/pnpm/releases/download/v${PV}/pnpm-linux-arm64 -> ${P}-arm64 )
"
S=${WORKDIR}

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RESTRICT="strip"

QA_PREBUILT="usr/bin/pnpm"

src_compile() {
	cp "${DISTDIR}/${P}-${ARCH}" pnpm || die
	chmod +x pnpm || die
	./pnpm completion bash > "pnpm.bash" || die
}

src_install() {
	newbin "${DISTDIR}/${P}-${ARCH}" pnpm
	newbashcomp "pnpm.bash" pnpm
}
