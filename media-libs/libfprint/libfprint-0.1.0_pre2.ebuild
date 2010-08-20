# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P=${P/_/-}
DESCRIPTION="a library designed to support fingerprint readers"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI="mirror://sourceforge/fprint/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="-static -example -x11-example"

DEPEND=">=dev-libs/libusb-1.0.0
	media-gfx/imagemagick"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
}

src_compile(){
	econf $(use_enable static) \
		$(use_enable example examples-build) \
		$(use_enable x11-example x11-examples-build) \
		|| die "configuration failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
