# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ openfetion by LWP <levin108@gmail.com>, ebuild by Caspar Zhang
# <casparant@gmail.com>

EAPI="2"

inherit flag-o-matic subversion gnome2 eutils

ESVN_REPO_URI="http://ofetion.googlecode.com/svn/trunk/"
DESCRIPTION="A GTK IM client using CHINA MOBILE's Fetion Protocol 4"
HOMEPAGE="http://code.google.com/p/ofetion/"
SRC_URI=""
RESTRICT="mirror"
LANGS="zh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="nls +vanilla gstreamer notify +screensaver -debug"

DEPEND="gstreamer? ( media-libs/gstreamer )
		notify? ( x11-libs/libnotify )
		xscreensaver? ( x11-libs/libXScrnSaver )
		dev-libs/openssl
		>=x11-libs/gtk+-2.16.6
		dev-libs/libxml2"
RDEPEND=${DEPEND}

src_unpack() {
	subversion_src_unpack
}

src_configure() {
	econf $(use_enable nls) \
		$(use_enable gstreamer) \
		$(use_enable notify) \
		$(use_enable xscreensaver screensaver) \
		$(use_enable debug)
}
src_install() {
#	einstall
	emake DESTDIR="${D}" install || die "Install failed"

#without gstreamer , newmessage.wav is useless
	use gstreamer || rm "${D}/usr/share/openfetion/resource/newmessage.wav"

	einfo ""
	einfo "To use the sound reminder function, please enable gstreamer USE flag"
	einfo "and compile it again."
	einfo "Since v1.8 has some new feature, you might need to clean some data"
	einfo "cd ~/.openfetion && rm global.dat && find . -name "config.dat" -exec rm {} \;;"
}
