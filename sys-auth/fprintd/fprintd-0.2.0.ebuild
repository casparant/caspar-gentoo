# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="a D-Bus daemon offers libfprint functionality"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Fprintd"
SRC_URI="http://freedesktop.org/~hadess/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="-static -doc pam"

DEPEND=">=dev-libs/libusb-1.0.0
	>=media-libs/libfprint-0.2.0
	doc? ( dev-util/gtk-doc )
	pam? ( virtual/pam )"
RDEPEND="${DEPEND}"

src_compile() {
	econf --libdir=/ \
		$(use_enable doc gtk-doc-html) \
		$(use_enable pam) \
		$(use_enable static) || die "configuration failed"
	emake || die "make failed"
	rm pam/pam_${PN}.la -f
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
