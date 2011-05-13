# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit autotools eutils

DESCRIPTION="Chinese Lunar Library"
HOMEPAGE="http://liblunar.googlecode.com"
SRC_URI="http://liblunar.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="-doc"

RDEPEND="${RDEPEND}
	!dev-libs/liblunar
	doc? ( >=dev-util/gtk-doc-1 )
	>=dev-python/pygobject-2.11.5
	>=dev-libs/glib-2.4.0"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS ChangeLog NEWS README"

src_configure() {
	econf $(use_enable doc gtk-doc-html) \
		"--enable-static=no" || die "econf"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install"
}
