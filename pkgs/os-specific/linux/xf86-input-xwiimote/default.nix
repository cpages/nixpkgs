{ stdenv, fetchurl, pkgconfig, utilmacros, udev, xwiimote, xorgserver, xproto
, autoconf, automake, libtool
}:

stdenv.mkDerivation rec {
  name = "xf86-input-xwiimote-0.5";

  src = fetchurl {
    url = "https://github.com/dvdhrm/xf86-input-xwiimote/archive/${name}.tar.gz";
    sha256 = "0rfg0a2p2jyz2i953ladvvzhvq7g8q6qiz0fjagsfymfj60ndfiq";
  };

  buildInputs = [
    pkgconfig utilmacros udev xwiimote xorgserver xproto
    autoconf automake libtool
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  postInstall = ''
    mkdir -p $out/share/X11/xorg.conf.d
    cp 60-xorg-xwiimote.conf $out/share/X11/xorg.conf.d/
  '';

  meta = {
    description = "X.org XInput2 Wii Remote driver based on XWiimote";
    homepage = http://dvdhrm.github.io/xwiimote/;
	repositories.git = https://github.com/dvdhrm/xf86-input-xwiimote.git;
    license = stdenv.lib.licenses.mit;
    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.page ];
  };
}

