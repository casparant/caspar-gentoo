# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib

DESCRIPTION="P2P IPTV"
HOMEPAGE="http://www.pplive.com/en/download.htm"
SRC_URI="
	http://gmlive.googlecode.com/files/gmlive-extra.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=media-tv/gmlive-0.22"

RESTRICT="mirror"

src_install() {
	insinto /usr/bin
	chmod a+x ${WORKDIR}/gmlive-extra/xpplive
	doins ${WORKDIR}/gmlive-extra/xpplive
}
