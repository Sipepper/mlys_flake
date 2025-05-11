{ config, pkgs, nixpkgs-stable, inputs, lib, ... }:
{
  imports = [
    ./default.nix
  ];

  home.file = {
    ".wallpaper.jpg" = {
      source = pkgs.fetchurl {
        url = "https://images.unsplash.com/photo-1522124624696-7ea32eb9592c?q=80&w=2669&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
        sha256 = "sha256-7bwrUC19wzbDs0UZWkc3l20DvoWuL6/sbnzgsSkuRjc";
      };
    };
    ".config/pyradio/config".enable = true;
    ".config/pyradio/config".text = ''
      theme = catppuccin-mocha
    '';
    ".space.jpg" = {
      source = ./assets/space.jpg;
    };

    "Games/sega" = {
      source = ./assets/sega;
    };

  };

}
