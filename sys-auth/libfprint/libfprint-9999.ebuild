# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git eutils autotools

EGIT_REPO_URI="git://github.com/dsd/libfprint.git"
#EGIT_BRANCH="libusb-1.0"
#EGIT_TREE="libusb-1.0"


DESCRIPTION="libfprint"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="media-gfx/imagemagick
	dev-libs/libusb"

src_unpack() {
	git_src_unpack
	cd ${S}
	./autogen.sh	
	eautoreconf
	epatch "${FILESDIR}/${PN}-0.1.0~pre2+upeke2driver.patch"
	epatch "${FILESDIR}/0001-Add-gdk-pixbuf-support.patch"
	epatch "${FILESDIR}/0001-Add-some-corrective-action-if-there-are-missing-pack.patch"
	epatch "${FILESDIR}/0001-Add-udev-rules-to-set-devices-to-autosuspend.patch"
	epatch "${FILESDIR}/0001-Dont-consider-the-scan-complete-unless-there-is-atle.patch"
	epatch "${FILESDIR}/0001-Fix-a-segfault-that-occured-if-a-scan-was-shorter-th-0001.patch"
	epatch "${FILESDIR}/0002-Make-the-2-right-shift-correction-happen-on-image-ha.patch"
	epatch "${FILESDIR}/0002-upexonly.c-Fix-a-vertical-distortion-in-image-data.patch"
	epatch "${FILESDIR}/0004-libfprint-nuke-upeksonly.patch"
}

src_compile() {
	econf || die "econf died"
	emake || die "emake died"
}

src_install() {
	emake DESTDIR="${D}" install || "emake install failed"
}
