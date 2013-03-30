{ stdenv, fetchurl, pkgconfig, wayland, mesa, libxkbcommon
, cairo, libxcb, libXcursor, x11, udev, libdrm, mtdev
, libjpeg, pam, autoconf, automake, libtool }:

let version = "1.0.6"; in

stdenv.mkDerivation rec {
  name = "weston-${version}";

  src = fetchurl {
    url = "http://wayland.freedesktop.org/releases/${name}.tar.xz";
    sha256 = "1wclp1p4cg1a0aky4b1km6d0672k842j4mwvcg962xb6r16vqcy8";
  };

  buildInputs = [ pkgconfig wayland mesa libxkbcommon
    cairo libxcb libXcursor x11 udev libdrm mtdev
    libjpeg pam autoconf automake libtool ];

  preConfigure = "autoreconf -vfi";

  # prevent install target to chown root weston-launch, which fails
  configureFlags = ''
    --disable-setuid-install
  '';

  meta = {
    description = "Reference implementation of a Wayland compositor";
    homepage = http://wayland.freedesktop.org/;
    license = stdenv.lib.licenses.mit;
  };
}
