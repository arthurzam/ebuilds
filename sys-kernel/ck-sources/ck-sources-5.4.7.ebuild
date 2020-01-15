# Copyright 2019 kuzetsa℠ and others
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE="sources"

K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="8"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~amd64 ~x86"
HOMEPAGE="https://dev.gentoo.org/~mpagano/genpatches/
	http://kernel.kolivas.org/"
IUSE="experimental"

K_BRANCH_ID="${KV_MAJOR}.${KV_MINOR}"

DESCRIPTION="Gentoo's genpatches for Linux ${K_BRANCH_ID}, with Con Kolivas' MuQSS process scheduler."

MUQSS_PATCHSET_FILE="http://ck.kolivas.org/patches/5.0/${K_BRANCH_ID}/${K_BRANCH_ID}-ck1/${K_BRANCH_ID}-ck1-broken-out.tar.xz"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${MUQSS_PATCHSET_FILE}"

UNIPATCH_LIST="${DISTDIR}/${K_BRANCH_ID}-ck1-broken-out.tar.xz"
#UNIPATCH_EXCLUDE="0002-Fix-Werror-build-failure-in-tools.patch"
UNIPATCH_STRICTORDER="yes"
