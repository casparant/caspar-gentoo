# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit gnome2

DESCRIPTION="Guake is a drop-down terminal for Gnome"
HOMEPAGE="http://guake-terminal.org/"
SRC_URI="http://trac.guake-terminal.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	dev-python/gnome-python
	dev-python/notify-python
	x11-libs/vte[python]"

src_configure() {
	econf || die "configuration failed"
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	emake DESTDIR="${D}" install || die "installation failed"
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	
}

pkg_preinst() {
	gnome2_gconf_savelist
}

