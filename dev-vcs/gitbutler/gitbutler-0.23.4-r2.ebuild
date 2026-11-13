# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

declare -A GIT_CRATES=(
	[calloop]='https://github.com/zed-industries/calloop;3759371fee14c40066d64777e2a36b6ffcc22590;calloop-%commit%'
	[collections]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/collections'
	[deltoids]='https://github.com/juanibiapina/deltoids;b797d011ecc6b733025461cc98fae6f9f8719429;deltoids-%commit%/crates/deltoids'
	[derive_refineable]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/refineable/derive_refineable'
	[file-id]='https://github.com/notify-rs/notify;978fe719b066a8ce76b9a9d346546b1569eecfb6;notify-%commit%/file-id'
	[git-meta-lib]='https://github.com/git-meta/git-meta;335159aa4db1231d5bbea88184455638ac68b5b5;git-meta-%commit%/crates/git-meta-lib'
	[git2]='https://github.com/gitbutlerapp/git2-rs;a87a7bb3f6843504339fe7434ee0732a3e968f3e;git2-rs-%commit%'
	[gix-actor]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-actor'
	[gix-attributes]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-attributes'
	[gix-bitmap]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-bitmap'
	[gix-blame]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-blame'
	[gix-chunk]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-chunk'
	[gix-command]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-command'
	[gix-commitgraph]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-commitgraph'
	[gix-config-value]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-config-value'
	[gix-config]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-config'
	[gix-credentials]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-credentials'
	[gix-date]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-date'
	[gix-diff]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-diff'
	[gix-dir]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-dir'
	[gix-discover]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-discover'
	[gix-error]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-error'
	[gix-filter]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-filter'
	[gix-fs]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-fs'
	[gix-glob]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-glob'
	[gix-hash]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-hash'
	[gix-hashtable]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-hashtable'
	[gix-ignore]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-ignore'
	[gix-imara-diff]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-imara-diff'
	[gix-index]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-index'
	[gix-lock]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-lock'
	[gix-macros]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-macros'
	[gix-mailmap]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-mailmap'
	[gix-merge]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-merge'
	[gix-negotiate]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-negotiate'
	[gix-note]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-note'
	[gix-object]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-object'
	[gix-odb]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-odb'
	[gix-pack]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-pack'
	[gix-packetline]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-packetline'
	[gix-parallel]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-parallel'
	[gix-path]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-path'
	[gix-pathspec]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-pathspec'
	[gix-prompt]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-prompt'
	[gix-protocol]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-protocol'
	[gix-quote]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-quote'
	[gix-ref]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-ref'
	[gix-refspec]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-refspec'
	[gix-revision]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-revision'
	[gix-revwalk]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-revwalk'
	[gix-sec]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-sec'
	[gix-shallow]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-shallow'
	[gix-status]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-status'
	[gix-submodule]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-submodule'
	[gix-tempfile]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-tempfile'
	[gix-testtools]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/tests/tools'
	[gix-trace]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-trace'
	[gix-transport]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-transport'
	[gix-traverse]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-traverse'
	[gix-url]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-url'
	[gix-utils]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-utils'
	[gix-validate]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-validate'
	[gix-worktree-state]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-worktree-state'
	[gix-worktree-stream]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-worktree-stream'
	[gix-worktree]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-worktree'
	[gix-zlib]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix-zlib'
	[gix]='https://github.com/GitoxideLabs/gitoxide;4dc73c31afa936828fca5bbf69ada5a94c480d43;gitoxide-%commit%/gix'
	[gpui]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/gpui'
	[gpui_apple]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/gpui_apple'
	[gpui_ios]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/gpui_ios'
	[gpui_linux]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/gpui_linux'
	[gpui_macos]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/gpui_macos'
	[gpui_macros]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/gpui_macros'
	[gpui_platform]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/gpui_platform'
	[gpui_shared_string]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/gpui_shared_string'
	[gpui_util]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/gpui_util'
	[gpui_web]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/gpui_web'
	[gpui_wgpu]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/gpui_wgpu'
	[gpui_windows]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/gpui_windows'
	[http_client]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/http_client'
	[libghostty-vt-sys]='https://github.com/uzaaft/libghostty-rs;cd4d497e8c698b27054a677ce19d1bd1a1a4d8bf;libghostty-rs-%commit%/crates/libghostty-vt-sys'
	[libghostty-vt]='https://github.com/uzaaft/libghostty-rs;cd4d497e8c698b27054a677ce19d1bd1a1a4d8bf;libghostty-rs-%commit%/crates/libghostty-vt'
	[libgit2-sys]='https://github.com/gitbutlerapp/git2-rs;a87a7bb3f6843504339fe7434ee0732a3e968f3e;git2-rs-%commit%/libgit2-sys'
	[minus]='https://github.com/arijit79/minus;57f1848f831d153a10d65060562ce1fdde938a01;minus-%commit%'
	[naga-types]='https://github.com/gfx-rs/wgpu;3b3506ea31154edc04de64debda0e780cba2639c;wgpu-%commit%/naga-types'
	[naga]='https://github.com/gfx-rs/wgpu;3b3506ea31154edc04de64debda0e780cba2639c;wgpu-%commit%/naga'
	[proptest-macro]='https://github.com/proptest-rs/proptest;3dca198a8fef1b32e3a66f1e1897c955b4dc5b5b;proptest-%commit%/proptest-macro'
	[proptest]='https://github.com/proptest-rs/proptest;3dca198a8fef1b32e3a66f1e1897c955b4dc5b5b;proptest-%commit%/proptest'
	[refineable]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/refineable'
	[scheduler]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/scheduler'
	[sum_tree]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/sum_tree'
	[tauri-plugin-trafficlights-positioner]='https://github.com/gitbutlerapp/tauri-plugin-trafficlights-positioner;57a6c6a2c58b99db32bbc710d37dc293245408dd;tauri-plugin-trafficlights-positioner-%commit%'
	[wasm_thread]='https://github.com/zed-industries/wasm_thread;0cf96c7708dfb97ccf3da50347e25edcf75d6937;wasm_thread-%commit%'
	[wgpu-core-deps-apple]='https://github.com/gfx-rs/wgpu;3b3506ea31154edc04de64debda0e780cba2639c;wgpu-%commit%/wgpu-core/platform-deps/apple'
	[wgpu-core-deps-emscripten]='https://github.com/gfx-rs/wgpu;3b3506ea31154edc04de64debda0e780cba2639c;wgpu-%commit%/wgpu-core/platform-deps/emscripten'
	[wgpu-core-deps-linux-android-bsd]='https://github.com/gfx-rs/wgpu;3b3506ea31154edc04de64debda0e780cba2639c;wgpu-%commit%/wgpu-core/platform-deps/linux-android-bsd'
	[wgpu-core-deps-wasm]='https://github.com/gfx-rs/wgpu;3b3506ea31154edc04de64debda0e780cba2639c;wgpu-%commit%/wgpu-core/platform-deps/wasm'
	[wgpu-core-deps-windows]='https://github.com/gfx-rs/wgpu;3b3506ea31154edc04de64debda0e780cba2639c;wgpu-%commit%/wgpu-core/platform-deps/windows'
	[wgpu-core]='https://github.com/gfx-rs/wgpu;3b3506ea31154edc04de64debda0e780cba2639c;wgpu-%commit%/wgpu-core'
	[wgpu-hal]='https://github.com/gfx-rs/wgpu;3b3506ea31154edc04de64debda0e780cba2639c;wgpu-%commit%/wgpu-hal'
	[wgpu-naga-bridge]='https://github.com/gfx-rs/wgpu;3b3506ea31154edc04de64debda0e780cba2639c;wgpu-%commit%/wgpu-naga-bridge'
	[wgpu-sync]='https://github.com/gfx-rs/wgpu;3b3506ea31154edc04de64debda0e780cba2639c;wgpu-%commit%/wgpu-sync'
	[wgpu-types]='https://github.com/gfx-rs/wgpu;3b3506ea31154edc04de64debda0e780cba2639c;wgpu-%commit%/wgpu-types'
	[wgpu]='https://github.com/gfx-rs/wgpu;3b3506ea31154edc04de64debda0e780cba2639c;wgpu-%commit%/wgpu'
	[xim-ctext]='https://github.com/zed-industries/xim-rs;16f35a2c881b815a2b6cdfd6687988e84f8447d8;xim-rs-%commit%/xim-ctext'
	[xim-parser]='https://github.com/zed-industries/xim-rs;16f35a2c881b815a2b6cdfd6687988e84f8447d8;xim-rs-%commit%/xim-parser'
	[zed-font-kit]='https://github.com/zed-industries/font-kit;94b0f28166665e8fd2f53ff6d268a14955c82269;font-kit-%commit%'
	[zed-scap]='https://github.com/zed-industries/scap;4afea48c3b002197176fb19cd0f9b180dd36eaac;scap-%commit%'
	[zed-xim]='https://github.com/zed-industries/xim-rs;16f35a2c881b815a2b6cdfd6687988e84f8447d8;xim-rs-%commit%'
	[ztracing]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/ztracing'
	[ztracing_macro]='https://github.com/zed-industries/zed;28d0a3547f16b9609b301b48ab363bfca649c864;zed-%commit%/crates/ztracing_macro'
)

RUST_MIN_VER="1.98.0"
# libgit2 submodule of the git2 fork (libgit2-sys/libgit2)
LIBGIT2_PV="1.9.4"

inherit cargo desktop shell-completion xdg

DESCRIPTION="Git client for simultaneous branches (native GPUI client)"
HOMEPAGE="https://gitbutler.com/ https://github.com/gitbutlerapp/gitbutler"
SRC_URI="
	https://github.com/gitbutlerapp/gitbutler/archive/refs/tags/release/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/libgit2/libgit2/archive/v${LIBGIT2_PV}.tar.gz -> libgit2-${LIBGIT2_PV}.tar.gz
	${CARGO_CRATE_URIS}
"
SRC_URI+="https://github.com/gentoo-crate-dist/gitbutler/releases/download/release%2F${PV}/${PN}-release-${PV}-crates.tar.xz"
S="${WORKDIR}/${PN}-release-${PV}"

LICENSE="MIT"
# Embedded Inter and Geist Mono fonts
LICENSE+=" OFL-1.1"
# Dependent crate licenses
LICENSE+="
	0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0
	CC0-1.0 CDLA-Permissive-2.0 ISC MIT MPL-2.0 UoI-NCSA Unicode-3.0
	Unicode-DFS-2016 WTFPL-2 ZLIB BZIP2
"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

DEPEND="
	dev-db/sqlite:3
	dev-libs/oniguruma:=
	dev-libs/openssl:=
	media-libs/fontconfig
	media-libs/freetype
	net-misc/curl
	virtual/zlib:=
	x11-libs/libxcb:=
	x11-libs/libxkbcommon[X]
	dev-libs/libghostty-vt:=
"
# wayland and vulkan are dlopen()ed
RDEPEND="${DEPEND}
	dev-libs/wayland
	dev-vcs/git
	media-libs/vulkan-loader
"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-libghostty-vt-1.0.patch
)

src_prepare() {
	default

	# cargo.eclass can't override [patch.crates-io] git entries, so point
	# them at the unpacked GIT_CRATES directly.
	local crate commit dir sed_args=()
	for crate in calloop git2 gix; do
		IFS=';' read -r _ commit dir <<< "${GIT_CRATES[${crate}]}"
		sed_args+=( -e "/^${crate} = { git = /c${crate} = { path = \"${WORKDIR}/${dir//%commit%/${commit}}\" }" )
	done

	# github tarballs lack submodules, so fill in libgit2-sys's libgit2
	IFS=';' read -r _ commit dir <<< "${GIT_CRATES[libgit2-sys]}"
	dir="${WORKDIR}/${dir//%commit%/${commit}}/libgit2"
	rmdir "${dir}" || die
	mv "${WORKDIR}/libgit2-${LIBGIT2_PV}" "${dir}" || die

	# link the system libghostty-vt
	IFS=';' read -r _ commit dir <<< "${GIT_CRATES[libghostty-vt-sys]}"
	sed -e '/^default = /s/\["vendored"\]/["pkg-config", "link-dynamic"]/' \
		-i "${WORKDIR}/${dir//%commit%/${commit}}"/Cargo.toml || die

	# debundle openssl and sqlite. libgit2 stays bundled: git2 is built with
	# unstable-sha256, which needs libgit2 built with GIT_EXPERIMENTAL_SHA256
	sed "${sed_args[@]}" \
		-e '/^rusqlite = /s/features = \["bundled"\]/features = []/' \
		-e '/^    "vendored-openssl",$/d' \
		-i Cargo.toml || die

	# metrics are never sent without POSTHOG_API_KEY at build time, but have
	# the settings say so as well
	sed -e '/"app\(Metrics\|ErrorReporting\)Enabled"/s/true/false/' \
		-i crates/but-settings/assets/defaults.jsonc || die
}

src_configure() {
	# no key means no PostHog client, so no metrics or error reports
	unset POSTHOG_API_KEY
	export LIBSQLITE3_SYS_USE_PKG_CONFIG=1
	export RUSTONIG_SYSTEM_LIBONIG=1
	# share app data and settings with GitButler's release builds
	export CHANNEL=release
	export VERSION=${PV}

	cargo_src_configure
}

src_compile() {
	cargo_src_compile --package but-gpui --package gitbutler-git --package but --bins \
		--features but/packaged-but-distribution

	local but="$(cargo_target_dir)/but" shell
	for shell in bash zsh fish; do
		"${but}" completions ${shell} > "${T}/but.${shell}" || die
	done
}

src_test() {
	cargo_src_test --package but-gpui
}

src_install() {
	# the askpass helper has to sit next to the binary
	exeinto /usr/libexec/${PN}
	doexe "$(cargo_target_dir)"/{but,gitbutler-{gpui,git-askpass}}
	dosym -r /usr/libexec/${PN}/gitbutler-gpui /usr/bin/gitbutler-gpui
	dosym -r /usr/libexec/${PN}/but /usr/bin/but

	newbashcomp "${T}/but.bash" but
	newzshcomp "${T}/but.zsh" _but
	newfishcomp "${T}/but.fish" but.fish

	local size
	for size in 32 64 128; do
		newicon -s ${size} crates/gitbutler-tauri/icons/release/${size}x${size}.png ${PN}.png
	done
	newicon -s 256 crates/gitbutler-tauri/icons/release/128x128@2x.png ${PN}.png
	newicon -s 512 crates/gitbutler-tauri/icons/release/icon.png ${PN}.png
	make_desktop_entry gitbutler-gpui GitButler ${PN} "Development;RevisionControl;" \
		"StartupWMClass=gitbutler-gpui"

	dodoc crates/but-gpui/README.md
}
