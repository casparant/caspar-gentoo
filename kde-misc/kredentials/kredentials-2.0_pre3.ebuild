# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

MY_P="${PN}-${PV/_/-}"
DESCRIPTION="a KDE systray applet for keeping Kerberos and AFS authentication
tokens current."
HOMEPAGE="http://freecode.com/projects/kredentials"
SRC_URI="http://people.csail.mit.edu/noahm/${PN}/2.0/${MY_P}.tar.bz2"

S="${WORKDIR}/${MY_P}"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/pkgconfig"
DEPEND=""
