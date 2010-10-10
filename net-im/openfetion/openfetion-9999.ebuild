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
<<<<<<< HEAD
IUSE_LINGUAS="en zh_CN"
IUSE="+nls +vanilla -gstreamer -notify -debug ${IUSE_LINGUAS// / linguas_}"
=======
IUSE="+vanilla -gstreamer -notify -debug"
>>>>>>> parent of 49f2508... update openfetion

DEPEND="gstreamer? ( media-libs/gstreamer )
		notify? ( x11-libs/libnotify )
		dev-libs/openssl
		>=x11-libs/gtk+-2.16.6
		dev-libs/libxml2"
RDEPEND=${DEPEND}

src_unpack() {
	subversion_src_unpack
}

src_configure() {
	local myconf=""
	use debug && myconf="${myconf} --enable-debug"
	econf ${myconf}
}

src_install() {
	local X
	for X in ${ISUE_LINGUAS}; do
		if use linguas_${X}; then
			export LINGUAS="$LINGUAS ${X}"
		fi
	done
#	einstall
	emake DESTDIR="${D}" install || die "Install failed"
#	emake DESTDIR="${D}" -C po install || die "Install tranlation files failed"

#   do some cleanup

#clean up the makefiles unwanted
	rm ${D}/usr/share/openfetion/skin/face_images/Makefile{,.in,.am}

#without gstreamer , newmessage.wav is useless
	use gstreamer || rm "${D}/usr/share/openfetion/resource/newmessage.wav"

	einfo ""
	einfo "To use the sound reminder function, please enable gstreamer USE flag"
	einfo "and compile it again."
	einfo "v1.8 has some new feature, you might need to clean some data"
	einfo "cd ~/.openfetion && rm global.dat && find . -name "config.dat" -exec rm {} \;;"
}
