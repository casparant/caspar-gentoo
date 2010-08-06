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
EPATCH_OPTS="-p1 -d ${S}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/0001-Add-gdk-pixbuf-support.patch"
	epatch "${FILESDIR}/0001-Add-udev-rules-to-set-devices-to-autosuspend.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
}

