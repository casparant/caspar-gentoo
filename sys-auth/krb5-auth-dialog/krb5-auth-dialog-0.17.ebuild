# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils gnome2 virtualx

DESCRIPTION="a tray applet for the GNOME Desktop that monitors Kerberos tickets"
HOMEPAGE="https://honk.sigxcpu.org/piki/projects/krb5-auth-dialog/"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls gtk2 -gtk3 libnotify pam networkmanager -debug"

DEPEND="dev-libs/glib
	sys-apps/dbus
	gnome-base/gconf
	gtk3? (
		gtk2? ( x11-libs/gtk+:2 )
		!gtk2? ( x11-libs/gtk+:3 ) )
	!gtk3? ( x11-libs/gtk+:2 )
	libnotify? ( x11-libs/libnotify )
	pam? ( sys-libs/pam )
	networkmanager? ( net-misc/networkmanager )
	app-crypt/mit-krb5"
RDEPEND="${DEPEND}"

src_configure() {
	if use gtk3 && ! use gtk2; then
		GTK_VER=3.0
	else
		GTK_VER=2.0
	fi

	econf --with-gtk=${GTK_VER} \
		$(use_enable nls) \
		$(use_with libnotify) \
		$(use_with pam) \
		$(use_enable networkmanager network-manager)
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die
}
