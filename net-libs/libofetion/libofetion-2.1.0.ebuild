# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils
CMAKE_MIN_VERSION="2.6"

DESCRIPTION="An open source lib of CHINA MOBILE's Fetion Protocol version 4"
HOMEPAGE="http://code.google.com/p/ofetion/"
SRC_URI="http://ofetion.googlecode.com/files/${P}.tar.gz"
RESTRICT="mirror"
LANGS="zh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""
DOCS=( AUTHORS ChangeLog README )

DEPEND="dev-db/sqlite:3
		dev-libs/openssl
		dev-libs/libxml2"
RDEPEND="${DEPEND}
		dev-util/pkgconfig"

src_install() {
	cmake-utils_src_install
}
