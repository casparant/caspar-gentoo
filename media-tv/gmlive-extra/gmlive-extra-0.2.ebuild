# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="some iptv program binaries."
HOMEPAGE="http://gmlive.googlecode.com"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="+pplive +pps +sopcast"

DEPEND=""
RDEPEND=">=media-tv/gmlive-0.22
	sopcast? ( media-tv/sopcast )"

src_unpack() {
	unpack ${A}
	if use pps; then
		cd ${P}
		unpack ./lib_pps.tar.gz
		cd ${S}
	fi
}

src_install() {
	if use pplive; then
		dobin xpplive
	fi
	if use pps; then
		# Since pps lib need root privilege to run,
		# I have to set suid for this bin file.
		# do this, and take your own risk!
		dobin xpps
		chmod u+s xpps
		dolib lib/lib*
	fi
}

pkg_postinst() {
	if use pps; then
		ewarn
		ewarn "xpps这个程序是用来支持ppstream网络流的。但它链接的库需要"
		ewarn "root权限去运行。因此采取折中的办法，只能给xpps加上suid位"
		ewarn "，才能让程序正确运行。请确保您熟知这一点，而由此可能造成"
		ewarn "的风险需要您自行承担。如果不同意，则不要运行xpps程序。并"
		ewarn "将之从硬盘上删除。"
		ewarn "lib_pps.tar.gz原是ppstream网站上提供的linux平台下的链接库"
		ewarn "。您也可以上http://dl.pps.tv/下载，及请求他们的支持。但这"
		ewarn "个库要求root权限才能跑,希望大家能够去提改善意见(要root来"
		ewarn "跑真的很没道理),而且还在/etc和/root目录里写配置文件。而这"
		ewarn "里提供的打包只是把配置文件改到/tmp下。保持用户/etc和root目"
		ewarn "录的干净。"
	fi
}
