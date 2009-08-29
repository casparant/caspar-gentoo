# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

ESVN_REPO_URI="http://${PN}.googlecode.com/svn/trunk"

inherit subversion

DESCRIPTION="Libpurple (Pidgin) plug-in supporting microblog services like Twitter"
HOMEPAGE="http://code.google.com/p/microblog-purple"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=" net-im/pidgin "
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake || die
	default
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}
