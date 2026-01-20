{ config, pkgs, ... }:
{
  imports = [
    ./default.nix
  ];

  xdg = {
    # Can create desktop entries via desktopEntries = { ... }
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
          "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
        };
      };
      extraPortals = [ 
        pkgs.xdg-desktop-portal-termfilechooser
      ];
    };
  };
  
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
  };
  
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
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
