# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Library to deal with pinyin"
HOMEPAGE="https://github.com/libpinyin/libpinyin"
SRC_URI="https://github.com/downloads/${PN}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sys-libs/db
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS ChangeLog INSTALL NEWS README )

src_install() {
	emake install DESTDIR="${D}" || "Install failed"
}
