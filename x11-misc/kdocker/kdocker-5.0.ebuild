# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kdocker/kdocker-4.8-r2.ebuild,v 1.6 2015/05/10 13:15:11 pesa Exp $

EAPI=5
inherit qt5-build qmake-utils

LANGS="en"

DESCRIPTION="Helper to dock any application into the system tray"
HOMEPAGE="http://kdocker.com/"
SRC_URI="https://github.com/user-none/KDocker/archive/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
S="$WORKDIR/KDocker-$PV"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsingleapplication[qt5(+),X]
	x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXpm
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS BUGS ChangeLog CREDITS README TODO )

src_test() {
	qt5-build_src_test
}
