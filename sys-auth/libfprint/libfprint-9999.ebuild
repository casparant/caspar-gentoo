# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git eutils autotools

EGIT_REPO_URI="git://anongit.freedesktop.org/${PN}/${PN}"
DESCRIPTION="library to add support for consumer fingerprint readers"
HOMEPAGE="http://cgit.freedesktop.org/libfprint/libfprint/"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X debug +examples static-libs"

RDEPEND="dev-libs/glib:2
	dev-libs/libusb:1
	dev-libs/nss
	x11-libs/gtk+
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )
	X? ( examples? (
		x11-libs/libXext
		x11-libs/libXv ) )"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_unpack() {
	git_src_unpack
	cd "${S}"
	./autogen.sh
	eautoreconf
}

pkg_setup() {
	einfo
	elog "This version does not support fdu2000 and upektc (yet)."
	einfo
}

src_configure() {
	local my_conf="$(use_enable examples examples-build)"
	if use X ; then
		my_conf="${my_conf} $(use_enable examples x11-examples-build)"
	else
		my_conf="${my_conf} --disable-x11-examples-build"
	fi
	econf ${my_conf} \
		$(use_enable debug debug-log) \
		$(use_enable static-libs static) || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	if use examples ; then
		dobin examples/{enroll,img_capture,verify{,_live}} || die
		if use X ; then
			dobin examples/img_capture_continuous || die
		fi
	fi
	dodoc AUTHORS HACKING NEWS README THANKS TODO || die
}
