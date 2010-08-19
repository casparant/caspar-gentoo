# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P=${P/_/-}
DESCRIPTION="libfprint"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI="mirror://sourceforge/fprint/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/libusb
	media-gfx/imagemagick"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
}
