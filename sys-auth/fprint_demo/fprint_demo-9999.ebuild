# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=3

inherit git eutils autotools

EGIT_REPO_URI="git://github.com/dsd/${PN}.git"

DESCRIPTION="a simple GTK+ application to demonstrate and test libfprint's capabilities"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Fprint_demo"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="=sys-auth/libfprint-9999
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}"

src_unpack() {
	git_src_unpack
	cd "${S}"
	./autogen.sh
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die
}
