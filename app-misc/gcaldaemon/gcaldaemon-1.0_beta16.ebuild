# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Java program that offers two-way synchronization between Google Calendar and various iCalendar compatible calendar applications."
HOMEPAGE="http://gcaldaemon.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-linux-${PV/_/-}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=virtual/jre-1.5"
DEPEND="${RDEPEND}"

src_install() {
	cd GCALDaemon
	sed -i "s|^GCALDIR=.*$|GCALDIR=/opt/${PN}|g" bin/password-encoder.sh
	sed -i "s|^GCALDIR=.*$|GCALDIR=/opt/${PN}|g" bin/standalone-start.sh
	sed -i "s|^GCALDIR=.*$|GCALDIR=/opt/${PN}|g" bin/sync-now.sh
	into /opt/${PN}
	dobin bin/*.sh || die "failed to install bin files"

	local dirs="conf lang lib log work"
	insinto /opt/${PN}
	doins -r $dirs || die "failed to install"
	
	insinto /etc/init.d/
	insopts -m0755
	doins ${FILESDIR}/${PN} || die "failed to install init.d file"
	
	if use doc; then
		dohtml -r docs/* || die "failed to install docs"
	fi
}

pkg_postinst() {
	ewarn 
	ewarn "Please run /opt/${PN}/bin/config-editor.sh as root before "
	ewarn "you launch the server."
}
