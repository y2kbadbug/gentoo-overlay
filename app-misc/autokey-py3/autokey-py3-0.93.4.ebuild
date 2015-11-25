# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit distutils python

DESCRIPTION="A programm for automating tasks in Linux"
HOMEPAGE="https://github.com/guoci/autokey-py3"
SRC_URI="https://pypi.python.org/packages/source/a/autokey-py3/${PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4 gtk"
REQUIRED_USE="|| ( gtk qt4 )"

PYTHON_DEPEND='3'
DEPEND="dev-python/python3-xlib
	dev-python/dbus-python
	gnome-extra/zenity
	media-gfx/imagemagick[svg]
	dev-python/pyinotify
	x11-misc/wmctrl
	x11-misc/xautomation
	x11-themes/hicolor-icon-theme
	x11-apps/xwd
	gtk? ( =dev-python/pygobject-3*
		x11-libs/libnotify
		dev-python/pygtksourceview )
	qt4? ( kde-base/pykde4
	    dev-python/qscintilla-python )"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${PV}"

src_install(){
	distutils_src_install
	doicon config/autokey-status-dark.svg config/autokey-status-light.svg config/autokey-status.svg config/autokey.svg config/autokey.png
	if use gtk ; then
		rm ${D}/usr/share/applications/autokey-qt.desktop
	fi
	if use qt4 ; then
		rm ${D}/usr/share/applications/autokey-gtk.desktop
	fi
}
