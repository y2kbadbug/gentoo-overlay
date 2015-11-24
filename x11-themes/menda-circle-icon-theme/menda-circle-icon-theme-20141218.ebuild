# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Menda Circle Icon Theme"
HOMEPAGE="https://github.com/manjaro/menda-icon-themes"
HOMEPAGE="https://github.com/anexation/menda-icon-themes"
GIT_COMMIT="1635665a21342da0ef5178612e9b412031c25655"
SRC_URI="${HOMEPAGE}/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"


LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	x11-themes/hicolor-icon-theme
	gnome-base/librsvg
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/menda-icon-themes-${GIT_COMMIT}"

src_prepare(){
	#Delete all broken symlinks
	rm Menda-Circle/apps/48x48/apps/chrome-pkclgpgponpjmpfokoepglboejdobkpl-Default.svg
    rm Menda-Circle/apps/scalable/chrome-pkclgpgponpjmpfokoepglboejdobkpl-Default.svg
 	rm Menda-Circle/places/scalable/edittrash.svg
 	rm Menda-Circle/places/scalable/stock_trash_full.svg
 	rm Menda-Circle/places/scalable/trashcan_full-new.svg
 	rm Menda-Circle/places/scalable/trashcan_full.svg

}

src_install(){
	insinto /usr/share/icons
	doins -r Menda-Circle
}
