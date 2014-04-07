{ stdenv, fetchurl, pkgconfig, udev, ncurses
, autoconf, automake, libtool
}:

#pick latest from git, as the only available tarball is quite outdated
let
  basename = "xwiimote";
  rev = "f2be57e24f";
in stdenv.mkDerivation {
  name = "${basename}-20131227";

  src = fetchurl {
    url = "https://api.github.com/repos/dvdhrm/xwiimote/tarball/${rev}";
    name = "${basename}-${rev}.tar.gz";
    sha256 = "063d4vrar9m1fcy7j9qxwvvc7kqa273d6wpzxky4py55x8606mql";
  };

  buildInputs = [
    pkgconfig udev ncurses
    autoconf automake libtool
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  postInstall = ''
    mkdir -p $out/share/X11/xorg.conf.d
    cp res/50-xorg-fix-xwiimote.conf $out/share/X11/xorg.conf.d/
  '';
 
  meta = {
    description = "Library to use Nintendo wiimotes";
    homepage = http://dvdhrm.github.io/xwiimote/;
    repositories.git = https://github.com/dvdhrm/xwiimote.git;
    license = stdenv.lib.licenses.mit;
    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.page ];
  };
}
