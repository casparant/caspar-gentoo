# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools subversion versionator

MY_PN="${PN/-/}"
DESCRIPTION="An OSD lyric show supporting multiple media players and downloading."
HOMEPAGE="http://code.google.com/p/osd-lyrics/"
ESVN_REPO_URI="http://${PN}.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="nls -mpd -xmms2 -amarok1"

DEPEND="
	mpd? ( media-sound/mpd )
	xmms2? ( media-sound/xmms2 )
	amarok1? ( <media-sound/amarok-2.0.0 )
	dev-libs/dbus-glib
	gnome-base/libglade
	net-misc/curl
	x11-libs/gtk+"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
	$(use_enable nls) \
	$(use_enable mpd) \
	$(use_enable xmms2) \
	$(use_enable amarok1) \
	|| die "conf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc ABOUT-NLS AUTHORS ChangeLog NEWS* README*
}
