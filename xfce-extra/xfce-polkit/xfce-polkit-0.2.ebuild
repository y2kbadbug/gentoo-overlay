# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit xfconf

DESCRIPTION="A simple PolicyKit authentication agent for XFCE"
HOMEPAGE="https://github.com/ncopa/xfce-polkit"
SRC_URI="https://github.com/ncopa/${PN}/releases/download/v${PV}/${PN}-${PV}.tar.gz"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="!!gnome-extra/polkit-gnome
		dev-vcs/git
		sys-auth/polkit
		xfce-base/libxfce4ui"

RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	domenu ${FILESDIR}/xfce-polkit.desktop
}
