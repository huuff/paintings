{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.wallrotate;
in
{

  options.services.wallrotate = {
    enable = lib.mkEnableOption "Automatically rotate wallpapers";

    package = lib.mkOption {
      type = lib.types.package;
      description = "Package to use";
      default = pkgs.callPackage ../packages/wallrotate.nix { };
    };

    intervalSeconds = lib.mkOption {
      type = lib.types.number;
      description = "Seconds to wait between rotations";
      default = 180;
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.wallrotate = {
      Unit = {
        Description = "Automatically rotate wallpapers";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = cfg.package;
        Environment = [
          "INTERVAL=${builtins.toString cfg.intervalSeconds}"
        ];
      };
    };
  };

}
