# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="2:2.7"
SRC_URI="http://download.sonarr.tv/v2/master/mono/NzbDrone.master.tar.gz"
MY_PN="NzbDrone"
S="${WORKDIR}/${MY_PN}"

inherit eutils user python systemd

DESCRIPTION="Sonarr (NZBDrone) is a PVR for Usenet and BitTorrent users."
HOMEPAGE="https://github.com/Sonarr/Sonarr"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=">=dev-lang/mono-3.2.8 media-video/mediainfo dev-db/sqlite"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	#Create the Sonarr group and user
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/sonarr ${PN}
}

src_unpack() {
	unpack ${A}
}

src_install() {
	newconfd "${FILESDIR}/${PN}.conf" ${PN}
	newinitd "${FILESDIR}/${PN}.init" ${PN}

	keepdir /var/${PN}
	fowners -R ${PN}:${PN} /var/${PN}

	insinto /etc/${PN}
	insopts -m0660 -o ${PN} -g ${PN}

	# Rotation of log files
	insinto /etc/logrotate.d
	insopts -m0644 -o root -g root
	newins "${FILESDIR}/${PN}.logrotate" ${PN}
	
	insinto "/usr/share/"
	doins -r "${S}"

    systemd_newunit "${FILESDIR}"/sonarr.service
}
