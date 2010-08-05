# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Use Fingerprint Devices with Linux"
HOMEPAGE="http://www.n-view.net/Appliance/fingerprint/"
SRC_URI="http://www.n-view.net/Appliance/fingerprint/download/${P}-src.tar.gz"

LICENSE="GPL-v3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/libfprint-0.1.0_pre2
x11-libs/libfakekey
>=app-crypt/qca-2.0.0
>=app-crypt/qca-gnupg-2.0.0_beta
>=app-crypt/qca-ossl-2.0.0_beta
!sys-auth/pam_fprint
|| ( ( x11-libs/qt-core x11-libs/qt-gui ) x11-libs/qt:4 )
"
RDEPEND="${DEPEND}"

src_configure() {
	sed -i 's/\/usr\/local/\/usr/' install.sh
	eqmake4
}

src_install() {
	yes no | ./install.sh || die "failed to install"
	dodoc CHANGELOG COPYING \
		Hacking.pdf IMPORTANT-UPGRADE-INFORMATION.txt Install-step-by-step.pdf
}
