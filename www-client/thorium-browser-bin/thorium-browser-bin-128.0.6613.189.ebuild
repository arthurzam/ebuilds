# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg unpacker

DESCRIPTION="Fast and secure browser for the modern web"
HOMEPAGE="https://thorium.rocks"
SRC_URI="
	cpu_flags_x86_avx2? (
		https://github.com/Alex313031/thorium/releases/download/M${PV}/thorium-browser_${PV}_AVX2.deb
	)
	!cpu_flags_x86_avx2? (
		cpu_flags_x86_avx? (
			https://github.com/Alex313031/thorium/releases/download/M${PV}/thorium-browser_${PV}_AVX.deb
		)
		!cpu_flags_x86_avx? (
			cpu_flags_x86_sse4_2? (
				https://github.com/Alex313031/thorium/releases/download/M${PV}/thorium-browser_${PV}_SSE4.deb
			)
			!cpu_flags_x86_sse4_2? (
				https://github.com/Alex313031/thorium/releases/download/M${PV}/thorium-browser_${PV}_SSE3.deb
			)
		)
	)
"
S=${WORKDIR}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cpu_flags_x86_sse3 cpu_flags_x86_sse4_2 cpu_flags_x86_avx cpu_flags_x86_avx2"
REQUIRED_USE="|| ( cpu_flags_x86_sse3 cpu_flags_x86_sse4_2 cpu_flags_x86_avx cpu_flags_x86_avx2 )"
RESTRICT="mirror strip test"

src_install() {
	insinto /opt/chromium.org/thorium/
	doins -r opt/chromium.org/thorium/.
	fperms +x opt/chromium.org/thorium/{thorium,thorium-browser,thorium_shell}
	fperms 4755 /opt/chromium.org/thorium/{chrome_crashpad_handler,chrome-sandbox}

	local sizes=( 16 24 32 48 64 128 256 )
	for size in "${sizes[@]}"; do
		local icon_path="opt/chromium.org/thorium/product_logo_${size}.png"
		local icon_name="thorium.png"
		newicon -s ${size} "${icon_path}" "${icon_name}"
	done

	domenu usr/share/applications/thorium-browser.desktop

	make_wrapper thorium-browser "/opt/chromium.org/thorium/thorium-browser"
}
