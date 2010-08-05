# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

FP_GUI=fingerprint-gui-0.14
MY_PN=${PN/-bin/}
DESCRIPTION="UPEK Biometric Services SDK for PC"
HOMEPAGE="http://www.upek.com/solutions/eikon/default.asp"
SRC_URI="http://www.n-view.net/Appliance/fingerprint/download/${FP_GUI}-src.tar.gz"

LICENSE="EULA"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="-headers"

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${FP_GUI}-src.tar.gz
	cd ${FP_GUI}/
}

src_install() {
	dodoc ${MY_PN}/Readme.pdf ${MY_PN}/releasenotes.txt ${MY_PN}/UPEK_EULA.pdf
	if use headers; then
		dodoc ${MY_PN}/doc/BSAPI.pdf  ${MY_PN}/doc/BSAPIUsageonLinux.pdf
		insinto /usr/include
		doins ${MY_PN}/include/bsapi.h
		doins ${MY_PN}/bserror.h
		doins ${MY_PN}/bstypes.h
	fi
	if use x86; then
		dolib ${MY_PN}/lib/libbsapi.so
	elif use amd64; then
		dolib ${MY_PN}/lib64/libbsapi.so
	fi
	insinto /etc/udev/rules.d
	doins ${MY_PN}/91-fingerprint-gui-upek.rules
	dodir /var/${MY_PN}_data
	echo "nvmprefix=\"/var/${MY_PN}_data/.NVM\" dualswipe=0" > ${MY_PN}/${MY_PN}.cfg
	insinto /etc
	doins ${MY_PN}/${MY_PN}.cfg
}
