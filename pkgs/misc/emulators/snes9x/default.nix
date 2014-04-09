{ stdenv, fetchgit, pkgconfig, gtk, libxml2, SDL, libXv, alsaLib, pulseaudio
, autoconf, automake, libtool, intltool
}:

stdenv.mkDerivation {
  name = "snes9x-2014.03.30";

  src = fetchgit {
    rev = "427ef85bd3be7ff8627478f3f18a71e5701c8e21";
    url = https://github.com/snes9xgit/snes9x.git;
    sha256 = "1pw7kr4qpazn1b5rn1ndwrh188w5p3ar30nmpacw7m6ganydrd49";
  };

  buildInputs = [ pkgconfig gtk libxml2 SDL libXv alsaLib pulseaudio
    autoconf automake libtool intltool
  ];

  preConfigure = ''
    cd gtk
    ./autogen.sh
  '';
 
  meta = {
    description = "Portable Super Nintendo Entertainment System emulator";
    homepage = https://code.google.com/p/snes9x-gtk/;
    repositories.git = https://github.com/snes9xgit/snes9x.git;
    license = stdenv.lib.licenses.lgpl21;
    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.page ];
  };
}
