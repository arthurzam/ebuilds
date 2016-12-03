EAPI=6

inherit autotools git-r3

DESCRIPTION="Intel media sdk dispatcher "
HOMEPAGE="https://github.com/lu-zero/mfx_dispatch"
EGIT_REPO_URI="https://github.com/lu-zero/mfx_dispatch.git"

LICENSE="BSD"
SLOT="0"

DEPEND="x11-libs/libva"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf
}
