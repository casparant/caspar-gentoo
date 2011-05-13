# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit qt4 pam

DESCRIPTION="Use Fingerprint Devices with Linux"
HOMEPAGE="http://www.n-view.net/Appliance/fingerprint/"
SRC_URI="http://www.n-view.net/Appliance/fingerprint/download/${P}-src.tar.gz"

LICENSE="GPL-v3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="upek"

DEPEND=">=sys-auth/libfprint-0.1.0_pre
x11-libs/libfakekey
>=app-crypt/qca-2.0.0
>=app-crypt/qca-gnupg-2.0.0_beta
>=app-crypt/qca-ossl-2.0.0_beta
!sys-auth/pam_fprint
!sys-auth/fprintd
|| ( ( x11-libs/qt-core x11-libs/qt-gui ) x11-libs/qt:4 )
"
RDEPEND="${DEPEND}
upek? ( sys-auth/upek-bin )"

src_configure() {

	# Something hard-coded exists, we left them in the
	# /usr/local directory :-\
	# sed -i 's#/usr/local#/usr#' install.sh \
	# 								include/Globals.h \
	#								bin/fingerprint-*/*.pro
	eqmake4 fingerprint.pro
}

src_install() {
	into /usr/local
	dobin bin/fingerprint-gui/fingerprint-gui
	dobin bin/fingerprint-helper/fingerprint-helper
	dobin bin/fingerprint-identifier/fingerprint-identifier
	dobin bin/fingerprint-plugin/fingerprint-plugin
	dobin bin/fingerprint-suid/fingerprint-suid
	fperms u+s /usr/local/bin/fingerprint-suid
	insinto /$(get_libdir)/security
	dopammod bin/fingerprint-pam/libpam_fingerprint-gui.so
	domenu bin/fingerprint-gui/fingerprint-gui.desktop
	dodoc CHANGELOG COPYING \
		Hacking.pdf IMPORTANT-UPGRADE-INFORMATION.txt Install-step-by-step.pdf
}

pkg_postinst() {
	elog "1) You should add the following line to the first of /etc/pam.d/system-auth"
	elog "   auth        sufficient  libpam_fingerprint-gui.so"
	elog "2) You must be in the plugdev group to use fingerprint"
	if use upek; then
		elog "3) You select to install upek, it's not open-sourced. Use it in your"
		elog "   own risk."
	fi
}
