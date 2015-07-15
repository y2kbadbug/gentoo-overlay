# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils user python systemd git-r3

PYTHON_DEPEND="2:2.7"

EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
if [[ $PV == 9999 ]]; then
	EGIT_BRANCH="develop"
else
	EGIT_COMMIT="v${PV}"
fi

EGIT_CHECKOUT_DIR=${WORKDIR}/${PN}

DESCRIPTION="Sonarr is a PVR for Usenet and BitTorrent users."
HOMEPAGE="https://github.com/Sonarr/Sonarr"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-lang/mono-3.2.8 media-video/mediainfo dev-db/sqlite"

S=${WORKDIR}/${PN}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/sonarr ${PN}
}

src_install() {
	newconfd "${FILESDIR}/${PN}.conf" ${PN}
	newinitd "${FILESDIR}/${PN}.init" ${PN}

	keepdir /var/${PN}
	fowners -R ${PN}:${PN} /var/${PN}

	insinto /etc/${PN}
	insopts -m0660 -o ${PN} -g ${PN}

	insinto /etc/logrotate.d
	insopts -m0644 -o root -g root
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	
	insinto "/usr/share/"
	doins -r "${S}"
	fowners -R ${PN}:${PN} /usr/share/${PN}

	systemd_dounit "${FILESDIR}/sonarr.service"
	systemd_newunit "${FILESDIR}/sonarr.service" "${PN}@.service"
}
