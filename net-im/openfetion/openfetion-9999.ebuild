# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ openfetion by LWP <levin108@gmail.com>, ebuild by Caspar Zhang
# <casparant@gmail.com>

EAPI="2"

inherit mercurial gnome2 cmake-utils eutils

#ESVN_REPO_URI="http://ofetion.googlecode.com/svn/trunk/"
EHG_REPO_URI="https://ofetion.googlecode.com/hg/"
DESCRIPTION="A GTK IM client using CHINA MOBILE's Fetion Protocol 4"
HOMEPAGE="http://code.google.com/p/ofetion/"
SRC_URI=""
RESTRICT="mirror"
LANGS="zh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="nls gstreamer libnotify +xscreensaver networkmanager"

DEPEND="gstreamer? ( media-libs/gstreamer )
		libnotify? ( x11-libs/libnotify )
		xscreensaver? ( x11-libs/libXScrnSaver )
		networkmanager? ( net-misc/networkmanager )
		dev-libs/glib:2
		x11-libs/gtk+:2
		x11-libs/gdk-pixbuf:2
		dev-db/sqlite:3
		dev-libs/openssl
		dev-libs/libxml2"
RDEPEND=${DEPEND}

src_unpack() {
	mercurial_src_unpack
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_disable nls)
		$(cmake-utils_use_with gstreamer)
		$(cmake-utils_use_with libnotify)
		$(cmake-utils_use_with xscreensaver LIBXSS)
		$(cmake-utils_use_with networkmanager)
		$(cmake-utils_use_with networkmanager DBUSGLIB)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	use gstreamer || rm "${D}/usr/share/openfetion/resource/newmessage.wav"
}

pkg_postinst() {
	if ! use gstreamer; then
		einfo ""
		einfo "To use the sound reminder function, please enable gstreamer USE flag"
		einfo "and compile it again."
	fi
}

