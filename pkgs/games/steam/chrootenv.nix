{ buildFHSChrootEnv, pkgs_i686, pkgs_x86_64
}:

buildFHSChrootEnv {
  name = "steam";
  pkgs = [ pkgs_i686.steam pkgs_i686.xterm pkgs_i686.xlibs.libX11
    pkgs_i686.gnome2.zenity pkgs_i686.python pkgs_i686.mesa pkgs_i686.xdg_utils
    pkgs_i686.dbus_tools pkgs_i686.alsaLib
    pkgs_x86_64.glibc ];
  profile = ''
    export LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib:/lib
    export FONTCONFIG_FILE=/etc/fonts/fonts.conf
  '';
}
