# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils multilib

DESCRIPTION="PPLive and PPS IPTV support for GMLive"
HOMEPAGE="http://code.google.com/p/gmlive/"
SRC_URI="
	http://gmlive.googlecode.com/files/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+pplive +pps"

DEPEND=""
RDEPEND=""

RESTRICT="primaryuri"

QA_PRESTRIPPED="
	usr/lib32/libppsvodnet.so
	usr/lib32/libppsvodres.so.0
	usr/lib32/libppsfds.so
	usr/lib32/libppsbase.so.0
	usr/lib32/libppssg.so.0.1.784
	usr/lib32/libppsapi.so
	usr/lib32/libppsvodres.so
	usr/lib32/libppsvodnet.so.0
	usr/lib32/libppsbase.so
	usr/lib32/libppssg.so
	usr/lib32/libppsfds.so.0.1.784
	usr/lib32/libppssg.so.0
	usr/lib32/libppsbase.so.0.1.784
	usr/lib32/libppsvodnet.so.0.1.784
	usr/lib32/libppsfds.so.0
	usr/lib32/libppsapi.so.0
	usr/lib32/libppsapi.so.0.1.784
	usr/lib32/libppsvodres.so.0.1.784"
QA_TEXTRELS="
	usr/lib32/libppsvodnet.so
	usr/lib32/libppsbase.so.0
	usr/lib32/libppsapi.so
	usr/lib32/libppsvodnet.so.0
	usr/lib32/libppsbase.so
	usr/lib32/libppsbase.so.0.1.784
	usr/lib32/libppsvodnet.so.0.1.784
	usr/lib32/libppsapi.so.0
	usr/lib32/libppsapi.so.0.1.784"

src_prepare() {
	if use pps ; then
		tar xvzf lib-826.tar.gz
		cp lib ppstream/ -R
	fi
}

src_compile() {
	if use pps ; then
		pushd ppstream/
		emake || die "emake failed"
		popd
	fi
}

src_install() {
	if use pps ; then
		dobin ppstream/xpps 
		use x86 || multilib_toolchain_setup x86
		insinto /usr/$(get_libdir)
		doins lib/*	
	fi

	if use pplive ; then
		dobin xpplive
	fi
}
