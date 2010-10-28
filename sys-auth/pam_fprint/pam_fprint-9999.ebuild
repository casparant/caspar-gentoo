# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://github.com/dsd/pam_fprint.git"

inherit git eutils autotools

DESCRIPTION="PAM module using libfprint's fingerprint for authentication"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Pam_fprint"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=sys-auth/libfprint-9999
	sys-libs/pam"

src_unpack() {
	git_src_unpack
	cd "${S}"
	./autogen.sh
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die
}
