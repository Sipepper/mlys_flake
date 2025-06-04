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

    ".config/pyradio/config" = {
      enable = true;
      text = ''
        theme = catppuccin-mocha
      '';
    };

    ".space.jpg" = {
      source = ./assets/space.jpg;
    };

    # ".config/yazi/relative-motions" = {
    #   source = pkgs.yaziPlugins.relative-motions;
    # };

    "Games/sega" = {
      source = ./assets/sega;
      # recursive = true;
      # force = true;
    };

    ".local/share/applications/kega-fusion.desktop" = {
      text = ''
        [Desktop Entry]
        Encoding=UTF-8
        Version=1.0
        Type=Application
        NoDisplay=true
        Exec=kega-fusion %f
        Name=Kega Fusion
      '';
    };
    ".assets/tex/preamble.tex" = { source = ./assets/tex/preamble.tex; };
    ".assets/tex/general.bib" = { source = ./assets/tex/bib.bib; };
    ".assets/tex/listings-rust.sty" = { source = ./assets/tex/listings-rust.sty; };

  };

}
