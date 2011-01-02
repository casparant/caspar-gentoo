# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils
CMAKE_MIN_VERSION="2.6"

DESCRIPTION="A GTK IM client using CHINA MOBILE's Fetion Protocol 4"
HOMEPAGE="http://code.google.com/p/ofetion/"
SRC_URI="http://ofetion.googlecode.com/files/${P}.tar.gz"
RESTRICT="mirror"
LANGS="zh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="gstreamer libnotify +xscreensaver networkmanager"
DOCS=( AUTHORS ChangeLog README )

DEPEND=">=net-libs/libofetion-2.1.0
		gstreamer? ( media-libs/gstreamer:0.10 )
		libnotify? ( x11-libs/libnotify )
		xscreensaver? ( x11-libs/libXScrnSaver )
		networkmanager? ( 
			net-misc/networkmanager 
			dev-libs/dbus-glib
		)
		dev-libs/glib:2
		x11-libs/gtk+:2
		x11-libs/gdk-pixbuf:2"
RDEPEND="${DEPEND}
		dev-util/pkgconfig
		sys-devel/gettext"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with gstreamer)
		$(cmake-utils_use_with libnotify)
		$(cmake-utils_use_with xscreensaver LIBXSS)
		$(cmake-utils_use_with networkmanager)
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
