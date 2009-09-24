# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

ESVN_REPO_URI="http://${PN}.googlecode.com/svn/trunk"

inherit qt4 subversion

DESCRIPTION="Qt4 cross-platform client for Twitter."
HOMEPAGE="http://code.google.com/p/qwit/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="|| ( ( x11-libs/qt-core x11-libs/qt-gui ) x11-libs/qt:4 )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_configure() {
	sed -i 's/\/usr\/local/\/usr/' qwit.pro
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "install failed"
	dodoc AUTHORS COPYING README
}
