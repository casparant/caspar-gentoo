# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="a library designed to support fingerprint readers, updated version"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI="http://people.freedesktop.org/~hadess/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="-static -example -x11-example"

DEPEND=">=dev-libs/libusb-1.0.0
	media-gfx/imagemagick"

src_compile(){
	econf $(use_enable static) \
		$(use_enable example examples-build) \
		$(use_enable x11-example x11-examples-build) \
		|| die "configuration failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	find "${D}" -name "*.la" -exec rm {} + || die "removal of *.la files failed"
}
