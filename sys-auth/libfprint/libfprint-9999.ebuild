# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git eutils autotools

#EGIT_REPO_URI="git://github.com/dsd/libfprint.git"
EGIT_REPO_URI="git://anongit.freedesktop.org/${PN}/${PN}"

DESCRIPTION="a library designed to support fingerprint readers, updated version"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-static"

DEPEND="media-gfx/imagemagick
	>=dev-libs/libusb-1.0.0"

src_unpack() {
	git_src_unpack
	cd "${S}"
	./autogen.sh
	eautoreconf
}

src_configure() {
	econf $(use_enable static) || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS COPYING HACKING NEWS README THANKS || die
	find "${D}" -name "*.la" -exec rm {} + || die "removal of *.la files failed"
}
