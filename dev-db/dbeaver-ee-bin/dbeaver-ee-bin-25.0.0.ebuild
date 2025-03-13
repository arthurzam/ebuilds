# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg

MY_PN=dbeaver

DESCRIPTION="Free universal database tool (community edition)"
HOMEPAGE="https://dbeaver.io/"
SRC_URI="
	amd64? ( https://dbeaver.com/files/${PV}/dbeaver-ee-${PV}-linux.gtk.x86_64-nojdk.tar.gz )
"
S=${WORKDIR}/${MY_PN}

LICENSE="Apache-2.0 EPL-1.0 BSD"
SLOT="0"
KEYWORDS="-* amd64"

RDEPEND=">=virtual/jre-17:*"

QA_PREBUILT="
	opt/${MY_PN}-ee.*
"

src_prepare() {
	sed -e "s/^Icon=.*/Icon=${MY_PN}/" \
		-e 's:/usr/share/dbeaver:/opt/dbeaver:g' \
		-e "s:^Exec=.*:Exec=${EPREFIX}/usr/bin/${MY_PN}:" \
		-i "${MY_PN}-ee.desktop" || die
	default
}

src_install() {
	doicon -s 128 "${MY_PN}.png"
	newicon icon.xpm "${MY_PN}.xpm"
	domenu "${MY_PN}-ee.desktop"

	local DOCS=( readme.txt )
	einstalldocs

	rm "${MY_PN}-ee.desktop" "${MY_PN}.png" icon.xpm readme.txt || die
	insinto "/opt/${MY_PN}-ee"
	doins -r ./*
	fperms 755 "/opt/${MY_PN}-ee/${MY_PN}"

	make_wrapper "${MY_PN}" "/opt/${MY_PN}-ee/${MY_PN}" "/opt/${MY_PN}-ee"
}
