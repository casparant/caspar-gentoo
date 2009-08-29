# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

ESVN_REPO_URI="http://${PN}.googlecode.com/svn/trunk"

inherit qt4 subversion

DESCRIPTION="An open-source Qt4 implementation of IP Messenger for linux."
HOMEPAGE="http://code.google.com/p/qipsmg/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="|| ( ( x11-libs/qt-core x11-libs/qt-gui ) x11-libs/qt:4 )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-fixpath.patch
}

src_compile() {
	emake || die "emake failed"
	default
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
