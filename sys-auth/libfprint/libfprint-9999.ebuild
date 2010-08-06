# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git eutils autotools

EGIT_REPO_URI="git://github.com/dsd/libfprint.git"

DESCRIPTION="libfprint"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="media-gfx/imagemagick
	dev-libs/libusb"

src_unpack() {
	./autogen.sh	
	eautoreconf
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	emake install || die "install failed"
}
