# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit qmake-utils

DESCRIPTION="Basic Meson build system integration for Qt Creator"
HOMEPAGE="https://github.com/qtcreator-meson-plugin/qtcreator-meson-plugin"

MY_COMMIT="7fd2aa8cee654f1ac9ae27069ead2aab4e4ea4ad"
QTC_VERSION=4.10.1
MY_QTCV=${QTC_VERSION/_/-}
MY_QTC=qt-creator-opensource-src-${MY_QTCV}
[[ ${MY_QTCV} == ${QTC_VERSION} ]] && MY_REL=official || MY_REL=development

SRC_URI="
	https://github.com/${PN}/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz
	https://download.qt.io/${MY_REL}_releases/qtcreator/${QTC_VERSION%.*}/${MY_QTCV}/${MY_QTC}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	=dev-qt/qt-creator-$(ver_cut 1-2)*
	dev-util/meson
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_configure() {
	local IDE_SOURCE_TREE=$(realpath ../qt-creator-opensource-src-${QTC_VERSION})
	eqmake5 DISTRO=gentoo IDE_SOURCE_TREE="${IDE_SOURCE_TREE}" IDE_BUILD_TREE="/usr" USE_USER_DESTDIR=no QTC_PREFIX="/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
