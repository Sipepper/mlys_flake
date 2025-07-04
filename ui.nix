{ config, pkgs, nixpkgs-stable, inputs, lib, ... }:
{
  imports = [
    ./default.nix
  ];


  home.sessionVariables.TERMCMD = "kitty --class=file_chooser";

  xdg = {
    configFile."xdg-desktop-portal-termfilechooser/config" = {
      force = true;
      text = ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      '';
    };
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common = {
          # default = [ "termfilechooser" "gtk" ];
          "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
        };
      };
      extraPortals = [ 
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-termfilechooser
        # pkgs.xdg-desktop-portal-gtk 
        # pkgs.xdg-desktop-portal-hyprland 
      ];
    };
  };
  
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };
  
  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    gtk3.extraConfig.gtk-decoration-layot = "menu:";
    font.name = config.default.main-font;
    iconTheme = {
      name = config.default.iconTheme.name;
      package = config.default.iconTheme.package;
    };
    cursorTheme = config.default.cursor;
  };

}
