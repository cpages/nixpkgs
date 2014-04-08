{ config, pkgs, ... }:

with pkgs.lib;

let
  cfg = config.services.xserver.wiimote;
in
{
  options = {
    services.xserver.wiimote = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable Wiimote support in X. This requires that the
		  Bluetooth stack is enabled. See http://dvdhrm.github.io/xwiimote/
		  for a detailed description of the procedure to get it working.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.xwiimote ]; # provides xwiishow
    services.xserver.modules = [ pkgs.xf86-input-xwiimote ];
    environment.etc."X11/xorg.conf.d/50-xorg-fix-xwiimote.conf".source = "${pkgs.xwiimote}/share/X11/xorg.conf.d/50-xorg-fix-xwiimote.conf";
    environment.etc."X11/xorg.conf.d/60-xorg-xwiimote.conf".source = "${pkgs.xf86-input-xwiimote}/share/X11/xorg.conf.d/60-xorg-xwiimote.conf";
  };
}
