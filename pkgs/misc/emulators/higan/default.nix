{ stdenv, fetchurl, pkgconfig, gtk, libX11, libXext, libXv, SDL
, alsaLib, libao, pulseaudio, openal, udev
}:

stdenv.mkDerivation {
  name = "higan-094";

  #trying to download tarball from the homepage returns: 406 Not Acceptable
  src = fetchurl {
    url = "https://gitorious.org/bsnes/bsnes/archive/10464b8c54085702b6ac8225aeb5bd01501ae5ee.tar.gz";
    sha256 = "0smnn068w9x20j3mpcq99bhl5jwzwi9ldaf3ssj8c79mmjjpzn16";
  };

  buildInputs = [ pkgconfig gtk libX11 libXext libXv SDL
    alsaLib libao pulseaudio openal udev
  ];

  patchPhase = ''
    sed -i -e s@/usr/local@$out@ nall/Makefile
    sed -i '/mkdir/d' ananke/Makefile
    sed -i -e s@sudo@@ ananke/Makefile
    sed -i -e s@/usr/local@$out@ ananke/Makefile
    sed -i -e s@sudo@@ shaders/Makefile
    sed -i -e s@/usr@$out@ shaders/Makefile
    sed -i -e s@sudo@@ target-ethos/Makefile
    sed -i -e s@/usr@$out@ target-ethos/Makefile
  '';

  buildPhase = ''
    make phoenix=gtk -C ananke
    make phoenix=gtk profile=performance
  '';

  installPhase = ''
    make install
    make install -C ananke
    make install -C shaders
    mv $out/bin/higan $out/bin/.higan-wrapped
    cat > $out/bin/higan << EOF
    #!${stdenv.shell}

    cp -ru $out/share/higan \$HOME/.config
    chmod u+w \$HOME/.config/higan -R
    LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:$out/lib $out/bin/.higan-wrapped "\$@"
    EOF

    chmod +x $out/bin/higan
  '';
 
  meta = {
    description = "A Nintendo multi-system emulator";
    homepage = http://byuu.org/higan/;
    repositories.git = https://git.gitorious.org/bsnes/bsnes.git;
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.page ];
  };
}
