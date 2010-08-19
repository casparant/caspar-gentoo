# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="a D-Bus daemon offers libfprint functionality"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Fprintd"
SRC_URI="http://freedesktop.org/~hadess/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-libs/libusb-1.0.0
	>=sys-auth/libfprint-0.2.0"
RDEPEND="${DEPEND}"
