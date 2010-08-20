# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git eutils autotools

EGIT_REPO_URI="git://anongit.freedesktop.org/libfprint/${PN}"

DESCRIPTION="a D-Bus daemon offers libfprint functionality"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Fprintd"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="-static -doc pam"

DEPEND=">=media-libs/libfprint-0.2.0
	>=dev-libs/libusb-1.0.0
	doc? ( dev-util/gtk-doc )
	pam? ( virtual/pam !sys-auth/pam_fprint )"

src_unpack() {
	git_src_unpack
	cd "${S}"
	./autogen.sh
	eautoreconf
}

src_compile() {
	econf --libdir=/lib \
		$(use_enable doc gtk-doc-html) \
		$(use_enable pam) \
		$(use_enable static) || die "configuration failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	find "${D}" -name "*.la" -exec rm {} + || die "removal of *.la files failed"
}

pkg_postinst() {
	if use pam; then
		einfo "You must add one line to /etc/pam.d/system-auth to enable PAM"
		einfo "module:"
		einfo "auth        sufficient  pam_fprintd.so"
		einfo ""
	fi
}
