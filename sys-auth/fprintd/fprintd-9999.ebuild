# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git eutils autotools

EGIT_REPO_URI="git://anongit.freedesktop.org/${PN}/${PN}"

DESCRIPTION="a D-Bus daemon offers libfprint functionality"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="media-gfx/imagemagick
	>=dev-libs/libusb-1.0.0"

src_unpack() {
	git_src_unpack
	cd "${S}"
	./autogen.sh
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
