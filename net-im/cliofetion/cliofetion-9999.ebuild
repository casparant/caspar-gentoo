# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit mercurial cmake-utils
CMAKE_MIN_VERSION="2.6"

EHG_REPO_URI="https://ofetion.googlecode.com/hg/"
DESCRIPTION="A command-line version of openfetion"
HOMEPAGE="http://code.google.com/p/ofetion/"
SRC_URI=""
RESTRICT="mirror"
LANGS="zh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""
DOCS=( AUTHORS ChangeLog README )

DEPEND=">=net-libs/libofetion-9999"
RDEPEND="${DEPEND}
		dev-util/pkgconfig"

src_unpack() {
	mercurial_src_unpack
	S=${WORKDIR}/${P}/${PN}
}

src_install() {
	cmake-utils_src_install
}
