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
KEYWORDS="~amd64"
IUSE="-static -doc pam"

DEPEND=">=dev-libs/libusb-1.0.0
	>=sys-auth/libfprint-0.2.0
	dev-util/gtk-doc
	pam? ( virtual/pam !sys-auth/pam_fprint )"
RDEPEND="${DEPEND}"

src_configure() {
	econf --libdir=/lib \
		$(use_enable doc gtk-doc-html) \
		$(use_enable pam) \
		$(use_enable static) || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	find "${D}" -name "*.la" -exec rm {} + || die "removal of *.la files failed"
	dodoc AUTHORS ChangeLog NEWS README || die
}

pkg_postinst() {
	if use pam; then
		einfo "You must add one line to /etc/pam.d/system-auth to enable PAM"
		einfo "module:"
		einfo "auth        sufficient  pam_fprintd.so"
		einfo ""
	fi
}
