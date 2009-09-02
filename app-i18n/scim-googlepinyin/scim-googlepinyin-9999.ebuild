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
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	|| ( >=app-i18n/scim-1.1 >=app-i18n/scim-cvs-1.1 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare(){
	./autogen.sh || die "autogen.sh failed with err_code $?"
}

src_install(){
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README* ChangeLog AUTHORS NEWS TODO || die "dodoc failed"
}

