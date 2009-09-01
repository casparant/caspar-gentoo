# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools git

EAPI="2"

DESCRIPTION="An SCIM port of android Google Pinyin IME"
HOMEPAGE="http://code.google.com/p/scim-googlepinyin/"
EGIT_REPO_URI="git://github.com/tchaikov/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=app-i18n/scim-1.4"
RDEPEND="${DEPEND}"

src_configure(){
	./autogen.sh
	econf || die "configure failed"
}

src_install(){
	emake INSTALL_ROOT="${D}" || die "make failed"
	emake INSTALL_ROOT="${D}" install || die "install faled"
}

