# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit qmake-utils

DESCRIPTION="SpellChecker Plugin for Qt Creator"
HOMEPAGE="https://github.com/CJCombrink/SpellChecker-Plugin"

QTC_VERSION=4.15.0
MY_QTCV=${QTC_VERSION/_/-}
MY_QTC=qt-creator-opensource-src-${MY_QTCV}
[[ ${MY_QTCV} == ${QTC_VERSION} ]] && MY_REL=official || MY_REL=development

SRC_URI="
	https://github.com/CJCombrink/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://download.qt.io/${MY_REL}_releases/qtcreator/${QTC_VERSION%.*}/${MY_QTCV}/${MY_QTC}.tar.xz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-text/hunspell:=
	=dev-qt/qt-creator-$(ver_cut 1-2 "${QTC_VERSION}")*
"
DEPEND="${RDEPEND}"

#S="${WORKDIR}/${PN}-${"

src_configure() {
	cat > spellchecker_local_paths.pri <<-EOF
		LOCAL_QTCREATOR_SOURCES=$(realpath ../qt-creator-opensource-src-${QTC_VERSION})
		LOCAL_IDE_BUILD_TREE=/usr
		LOCAL_HUNSPELL_LIB_DIR=/usr/$(get_libdir)
		LOCAL_HUNSPELL_SRC_DIR=/usr
		IDE_LIBRARY_BASENAME=$(get_libdir)
	EOF

	eqmake5 DISTRO=gentoo USE_USER_DESTDIR=no QTC_PREFIX="/usr" \
		KSYNTAXHIGHLIGHTING_LIB_DIR="${EPREFIX}/usr/$(get_libdir)" \
		KSYNTAXHIGHLIGHTING_INCLUDE_DIR="${EPREFIX}/usr/include/KF5/KSyntaxHighlighting"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
