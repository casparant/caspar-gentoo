# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="a library designed to support fingerprint readers, updated version"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI="http://freedesktop.org/~hadess/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-static"

DEPEND=">=dev-libs/libusb-1.0.0
	media-gfx/imagemagick"

src_configure() {
	econf $(use_enable static) || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die
	find "${D}" -name "*.la" -exec rm {} + || die "removal of *.la files failed"
}
