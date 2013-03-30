{ stdenv, fetchurl, libffi, expat, pkgconfig, libxslt, docbook_xsl, doxygen }:

let version = "1.0.6"; in

stdenv.mkDerivation rec {
  name = "wayland-${version}";

  src = fetchurl {
    url = "http://wayland.freedesktop.org/releases/${name}.tar.xz";
    sha256 = "0jgwf0lj8ch2iv505104h7vvay391l05d7pln0sg9vwryqnh2apm";
  };

  buildInputs = [ pkgconfig libffi expat libxslt docbook_xsl doxygen ];

  meta = {
    description = "Reference implementation of the wayland protocol";
    homepage = http://wayland.freedesktop.org/;
    license = stdenv.lib.licenses.mit;
    platforms = stdenv.lib.platforms.all;
  };
}
