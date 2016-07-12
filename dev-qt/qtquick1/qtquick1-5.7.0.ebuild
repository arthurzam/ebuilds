# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit qmake-utils git-r3

DESCRIPTION="Legacy declarative UI module for the Qt5 framework (deprecated)"
SLOT="5"
KEYWORDS="~amd64 ~x86"

EGIT_REPO_URI="https://code.qt.io/qt/qtquick1.git"
EGIT_CLONE_TYPE="shallow"
EGIT_BRANCH="${PV}"


IUSE="designer gles2 opengl webkit xml"

DEPEND="
	~dev-qt/qtcore-${PV}
	~dev-qt/qtgui-${PV}
	~dev-qt/qtnetwork-${PV}
	~dev-qt/qtscript-${PV}
	~dev-qt/qtsql-${PV}
	~dev-qt/qtwidgets-${PV}
	designer? (
		~dev-qt/designer-${PV}
		~dev-qt/qtdeclarative-${PV}
	)
	opengl? (
		~dev-qt/qtgui-${PV}[gles2=]
		~dev-qt/qtopengl-${PV}
	)
	webkit? ( ~dev-qt/qtwebkit-${PV} )
	xml? ( ~dev-qt/qtxmlpatterns-${PV} )
"
RDEPEND="${DEPEND}"

src_prepare() {
	if ! use designer; then
		sed -i src/plugins/plugins.pro -e "s/qtHaveModule(designer)/false/g"
	fi
	
	if ! use opengl; then
		sed -i src/imports/imports.pro -e "s/qtHaveModule(opengl)/false/g"
		sed -i tools/qml/qml.pri -e "s/qtHaveModule(opengl)/false/g"
	fi

	if ! use webkit; then
		sed -i src/imports/imports.pro -e "s/qtHaveModule(webkitwidgets)/false/g"
	fi

	if ! use xml; then
		sed -i src/declarative/declarative.pro -e "s/qtHaveModule(xmlpatterns)/false/g"
		sed -i src/declarative/util/util.pri -e "s/qtHaveModule(xmlpatterns)/false/g"
	fi

	QT5_PREFIX=${EPREFIX}/usr
	QT5_HEADERDIR=${QT5_PREFIX}/include/qt5
	QT5_LIBDIR=${QT5_PREFIX}/$(get_libdir)
	QT5_ARCHDATADIR=${QT5_PREFIX}/$(get_libdir)/qt5
	QT5_BINDIR=${QT5_ARCHDATADIR}/bin
	QT5_PLUGINDIR=${QT5_ARCHDATADIR}/plugins
	QT5_LIBEXECDIR=${QT5_ARCHDATADIR}/libexec
	QT5_IMPORTDIR=${QT5_ARCHDATADIR}/imports
	QT5_QMLDIR=${QT5_ARCHDATADIR}/qml
	QT5_DATADIR=${QT5_PREFIX}/share/qt5
	QT5_DOCDIR=${QT5_PREFIX}/share/doc/qt-${PV}
	QT5_TRANSLATIONDIR=${QT5_DATADIR}/translations
	QT5_EXAMPLESDIR=${QT5_DATADIR}/examples
	QT5_TESTSDIR=${QT5_DATADIR}/tests
	QT5_SYSCONFDIR=${EPREFIX}/etc/xdg
	readonly QT5_PREFIX QT5_HEADERDIR QT5_LIBDIR QT5_ARCHDATADIR \
			QT5_BINDIR QT5_PLUGINDIR QT5_LIBEXECDIR QT5_IMPORTDIR \
			QT5_QMLDIR QT5_DATADIR QT5_DOCDIR QT5_TRANSLATIONDIR \
			QT5_EXAMPLESDIR QT5_TESTSDIR QT5_SYSCONFDIR
	eapply_user
}

src_configure() {
	eqmake5
}

src_install() {
    emake INSTALL_ROOT="${D}" install
}
