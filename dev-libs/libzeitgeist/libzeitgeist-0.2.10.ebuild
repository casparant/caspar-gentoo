# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="a client library for applications that want to interact with the
Zeitgeist daemon"
HOMEPAGE="https://launchpad.net/libzeitgeist"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL v3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
>=dev-libs/glib-2.27.0-r1"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	find "${D}" -name "*.la" -exec rm {} + || die "removal of *.la files failed"
}
