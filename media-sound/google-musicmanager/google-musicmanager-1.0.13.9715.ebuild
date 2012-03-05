# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils toolchain-funcs versionator

SRC_BASE="http://dl.google.com/linux/direct"
DESCRIPTION="a simple app for adding the music files to Google Music library"
HOMEPAGE="http://music.google.com/music"
SRC_URI="
	x86? ( ${SRC_BASE}/${PN}-beta_current_i386.deb )
	amd64? ( ${SRC_BASE}/${PN}-beta_current_amd64.deb )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( app-arch/xz-utils app-arch/lzma-utils )"
RDEPEND="
	>=dev-libs/expat-1.95.8
	>=media-libs/flac-1.2.1
	>=media-libs/fontconfig-2.8.0
	>=media-libs/freetype-2.2.1
	>=sys-devel/gcc-4.1.1
	>=dev-libs/glib-2.12.0
	>=net-dns/libidn-1.13
	>=media-libs/libogg-1.0
	>=x11-libs/qt-core-4.5.1
	>=x11-libs/qt-gui-4.5.3
	>=media-libs/libvorbis-1.1.2
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	>=x11-misc/xdg-utils-1.0.2"

RESTRICT="mirror"

QA_EXECSTACK="opt/google/musicmanager/google-musicmanager"
QA_PRESTRIPPED="
	opt/google/musicmanager/libaudioenc.so.0
	opt/google/musicmanager/minidump_upload
	opt/google/musicmanager/libmpgdec.so.0
	opt/google/musicmanager/libaacdec.so
	opt/google/musicmanager/MusicManager
	opt/google/musicmanager/libid3tag.so"
#QA_TEXTRELS=""

pkg_nofetch() {
	elog "Please download"
	for i in ${A}; do
		[[ ${i} = ${PN}_* ]] && elog "${SRC_BASE}${i}"
	done
	elog "and save to ${DISTDIR}"
}

src_unpack() {
	for i in ${A}; do
		ar x "${DISTDIR}"/${i}
		if [[ ${i} = *.deb ]]; then
			if [[ -e "${WORKDIR}"/data.tar.lzma ]]; then
				mv "${WORKDIR}"/data.tar.lzma "${WORKDIR}"/${i%%_*}.tar.lzma
			elif [[ -e "${WORKDIR}"/data.tar.gz ]]; then
				mv "${WORKDIR}"/data.tar.gz "${WORKDIR}"/${i%%_*}.tar.gz
			else
				die "Can't find data from ${i}"
			fi
		fi
	done
}

src_install() {
	declare GOOGLE_MM_HOME="/opt/google/musicmanager"

	cd "${D}"
	lzma -cd "${WORKDIR}"/${PN}-beta.tar.lzma | tar xvf - || die "Couldn't extract"

	sed -i \
	"s|Icon=google-musicmanager|Icon=/opt/google/musicmanager/product_logo_32.png|g" \
	"${D}"${GOOGLE_MM_HOME}/${PN}.desktop
	domenu "${D}"${GOOGLE_MM_HOME}/${PN}.desktop
	rm "${D}"${GOOGLE_MM_HOME}/${PN}.desktop
}
