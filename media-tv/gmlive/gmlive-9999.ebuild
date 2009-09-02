# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

ESVN_REPO_URI="http://${PN}.googlecode.com/svn/trunk"

inherit autotools subversion

DESCRIPTION="The gtk frontend of the iptv \"mms\" and \"sopcast\""
HOMEPAGE="http://gmlive.googlecode.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nslive sopcast totem"

RDEPEND="dev-libs/libxml2
	>=dev-cpp/libglademm-2.4
	>=dev-cpp/gtkmm-2.4
	totem? ( >=media-video/totem-2.20[python] )"
DEPEND="${RDEPEND}
	gnome-base/gnome-common
	sys-devel/gettext
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.35"
RDEPEND="${RDEPEND}
	sopcast? ( media-tv/sopcast )
	nslive? ( media-tv/nslive )
	media-plugins/gst-plugins-libmms
	media-video/mplayer"

src_prepare() {
	sed -i \
		-e 's:channel.sopcast.com:channel.sopcast.cn:' \
		src/MainWindow.cpp || die "sed failed"
	sed -i \
		'55s/int on/on/' src/main.cpp || die "sed failed"
}

src_configure() {
	./autogen.sh
	econf $(use_enable totem plugin)
}

src_install() {
	emake install DESTDIR="${D}" || "Install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO.tasks
}
