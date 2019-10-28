# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit qmake-utils

DESCRIPTION="Basic Meson build system integration for Qt Creator"
HOMEPAGE="https://github.com/CJCombrink/SpellChecker-Plugin"

MY_COMMIT="dc2af6361367a7ba2d3a9f0b6205bdf66909b709"
QTC_VERSION=4.10.1
MY_QTCV=${QTC_VERSION/_/-}
MY_QTC=qt-creator-opensource-src-${MY_QTCV}
[[ ${MY_QTCV} == ${QTC_VERSION} ]] && MY_REL=official || MY_REL=development

SRC_URI="
	https://github.com/CJCombrink/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz
	https://download.qt.io/${MY_REL}_releases/qtcreator/${QTC_VERSION%.*}/${MY_QTCV}/${MY_QTC}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-text/hunspell:=
	=dev-qt/qt-creator-${PV}*
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_configure() {
	cat > spellchecker_local_paths.pri <<-EOF
		LOCAL_QTCREATOR_SOURCES=$(realpath ../qt-creator-opensource-src-${QTC_VERSION})
		LOCAL_IDE_BUILD_TREE=/usr
		LOCAL_HUNSPELL_LIB_DIR=/usr/lib
		LOCAL_HUNSPELL_SRC_DIR=/usr
	EOF

	eqmake5 DISTRO=gentoo USE_USER_DESTDIR=no QTC_PREFIX="/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
