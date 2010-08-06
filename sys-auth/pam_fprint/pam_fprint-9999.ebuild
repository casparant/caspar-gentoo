# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://github.com/dsd/pam_fprint.git"

inherit git eutils autotools

DESCRIPTION="pam_fprint"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Pam_fprint"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=sys-auth/libfprint-9999
	sys-libs/pam"

src_unpack() {
	git_src_unpack
	cd "${S}"
	./autogen.sh
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || "emake install failed"
}
