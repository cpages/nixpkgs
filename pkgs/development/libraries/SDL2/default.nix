{ stdenv, fetchurl, unzip, pkgconfig, audiofile
, openglSupport ? false, mesa ? null
, alsaSupport ? true, alsaLib ? null
, x11Support ? true, x11 ? null, libXrandr ? null
, pulseaudioSupport ? true, pulseaudio ? null
}:

# OSS is no longer supported, for it's much crappier than ALSA and
# PulseAudio.
assert alsaSupport || pulseaudioSupport;

assert openglSupport -> (mesa != null && x11Support);
assert x11Support -> (x11 != null && libXrandr != null);
assert alsaSupport -> alsaLib != null;
assert pulseaudioSupport -> pulseaudio != null;

let
  configureFlagsFun = attrs: ''
        --disable-oss --disable-video-x11-xme
        --disable-x11-shared --disable-alsa-shared --enable-rpath --disable-pulseaudio-shared
        --disable-osmesa-shared --enable-static
        ${if alsaSupport then "--with-alsa-prefix=${attrs.alsaLib}/lib" else ""}
      '';
in
stdenv.mkDerivation rec {
  name = "SDL-2-wl";

  src = fetchurl {
    url = https://github.com/soreau/SDL/zipball/176c3826ce34d51662e1a8a2090cf66892301785;
    sha256 = "1bbdx7gj01mlsfyy2grsvis87hibr752f242w8v6pkzpir067r9v";
    name  = "${name}.zip";
  };

  # Since `libpulse*.la' contain `-lgdbm', PulseAudio must be propagated.
  propagatedBuildInputs = stdenv.lib.optionals x11Support [ x11 libXrandr ] ++
    stdenv.lib.optional pulseaudioSupport pulseaudio;

  buildInputs = [ unzip pkgconfig audiofile ] ++
    stdenv.lib.optional openglSupport [ mesa ] ++
    stdenv.lib.optional alsaSupport alsaLib;

  # XXX: By default, SDL wants to dlopen() PulseAudio, in which case
  # we must arrange to add it to its RPATH; however, `patchelf' seems
  # to fail at doing this, hence `--disable-pulseaudio-shared'.
  configureFlags = configureFlagsFun { inherit alsaLib; };

  crossAttrs = {
      configureFlags = configureFlagsFun { alsaLib = alsaLib.crossDrv; };
  };

  passthru = {inherit openglSupport;};

  meta = {
    description = "A cross-platform multimedia library";
    homepage = http://www.libsdl.org/;
  };
}
