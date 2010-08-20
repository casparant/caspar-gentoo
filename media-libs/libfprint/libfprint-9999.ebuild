# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git eutils autotools

#EGIT_REPO_URI="git://github.com/dsd/libfprint.git"
EGIT_REPO_URI="git://anongit.freedesktop.org/${PN}/${PN}"

DESCRIPTION="a library designed to support fingerprint readers, updated version"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="-static -example -x11-example"

DEPEND="media-gfx/imagemagick
	>=dev-libs/libusb-1.0.0"

src_unpack() {
	git_src_unpack
	cd "${S}"
	./autogen.sh
	eautoreconf
}

src_compile(){
	econf $(use_enable static) \
		$(use_enable example examples-build) \
		$(use_enable x11-example x11-examples-build) \
		|| die "configuration failed"

	emake || die "make failed"
	find "${D}" -name "*.la" -exec rm {} + || die "removal of *.la files failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
