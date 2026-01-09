{ config, pkgs, lib, ... }:
let
  cfg = config.default;
in
{
  options.default = {
    enable = lib.mkEnableOption "enable";
    main-font = lib.mkOption {
      type = lib.types.str;
      default = "Iosevka Custom";
    };
    term-font = lib.mkOption {
      type = lib.types.str;
      default = "Iosevka Term NF";
    };
    cursor = lib.mkOption {
      type = lib.types.attrs;
      default = {
        name = "Vanilla-DMZ";
        package = pkgs.vanilla-dmz;
        size = 32;
      };
    };
    colors = lib.mkOption {
      type = lib.types.attrs;
      default = {
        background = "192330"; # #192330
        text = "ffffff";       # #ffffff
        border = "64727d";     # #64727d
      };
    };
    isPC = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    iconTheme = lib.mkOption {
      type = lib.types.attrs;
      default = {
        name = "Shine";
        package = pkgs.numix-icon-theme;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    default = {
      main-font = "Hurmit Nerd Font";
      term-font = "Iosevka Term NF";
      cursor = {
        name = "Vanilla-DMZ";
        package = pkgs.vanilla-dmz;
        size = 32;
      };
      colors = {
        background = "2b303b"; # #2b303b
        text = "ffffff";       # #ffffff
        border = "64727d";     # #64727d
      };
      isPC = true;
      iconTheme = {
        name = "Shine";
        package = pkgs.numix-icon-theme;
      };
    };
  };
}

