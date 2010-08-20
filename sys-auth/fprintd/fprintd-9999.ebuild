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

DEPEND="media-gfx/imagemagick
	>=dev-libs/libusb-1.0.0
	doc? ( dev-util/gtk-doc )
	pam? ( virtual/pam )"

src_unpack() {
	git_src_unpack
	cd "${S}"
	./autogen.sh
	eautoreconf
}

src_compile() {
	econf --libdir=/ \
		$(use_enable doc gtk-doc-html) \
		$(use_enable pam) \
		$(use_enable static) || die "configuration failed"
	emake || die "make failed"
	rm pam/pam_${PN}.la -f
}
