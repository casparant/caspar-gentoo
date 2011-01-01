# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ openfetion by LWP <levin108@gmail.com>, ebuild by Caspar Zhang
# <casparant@gmail.com>

EAPI=2

inherit mercurial cmake-utils eutils

EHG_REPO_URI="https://ofetion.googlecode.com/hg/"
DESCRIPTION="An open source wrapper of CHINA MOBILE's Fetion Protocol version 4"
HOMEPAGE="http://code.google.com/p/ofetion/"
SRC_URI=""
RESTRICT="mirror"
LANGS="zh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

DEPEND="dev-db/sqlite:3
		dev-libs/openssl
		dev-libs/libxml2"
RDEPEND=${DEPEND}

src_unpack() {
	mercurial_src_unpack
}

MY_S=${S}/${PN}
src_configure() {
	cd ${MY_S}
	cmake-utils_src_configure
}

src_install() {
	cd ${MY_S}
	cmake-utils_src_install
}
