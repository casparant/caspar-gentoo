# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="PAM module using libfprint's fingerprint for authentication"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Pam_fprint"
SRC_URI="mirror://sourceforge/fprint/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="media-libs/libfprint
	sys-libs/pam"
