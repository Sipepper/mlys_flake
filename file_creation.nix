{ pkgs, ... }:
{
  imports = [
    ./default.nix
  ];

  home.file = {
    ".wallpaper.png" = {
      source = ./assets/wallpaper.png;
    };

    ".config/pyradio/config" = {
      enable = true;
      text = ''
        theme = catppuccin-mocha
      '';
    };

    ".space.jpg" = { source = ./assets/space.jpg; };

    "Games/sega" = { source = ./assets/sega; };
    "Git/.readme.md" = { text = "Primary folder for git repos."; };
    "Rust/.readme.md" = { text = "Primary folder for programming projects."; };
    "Games/.readme.md" = { text = "Primary folder for games outside of Steam."; };
    "Books/.readme.md" = { text = "Primary folder for books, i.e. **The Library**."; };
    "Work/.readme.md" = { text = "Primary folder for non-math work."; };
    "Documents/.readme.md" = { text = "Primary folder for legal and other documents."; };
    "LaTeX/.readme.md" = { text = "Primary folder for math papers projects."; };

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

    ".local/share/applications/nvim.desktop" = {
      text = ''
        [Desktop Entry]
        Categories=Utility;TextEditor
        Comment=Edit text files
        Exec=nvim
        GenericName=Text Editor
        Icon=nvim
        MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++
        Name=Neovim
        StartupNotify=true
        Terminal=true
        Type=Application
        Version=1.5
      '';
    };

    ".local/share/applications/yazi.desktop" = {
      text = ''
        [Desktop Entry]
        Type=Application
        Name=Yazi in Wezterm
        Comment=Launch Yazi file manager in the Wezterm terminal
        Exec=wezterm -e yazi
        Icon=yazi # Or specify the full path to an icon file, e.g., /path/to/yazi-icon.png
        Terminal=false # Wezterm handles the terminal, so we set this to false
        Categories=System;Utility;FileManager;
        MimeType=inode/directory;
      '';
    };

    ".assets/tex/preamble.tex" = { source = ./assets/tex/preamble.tex; };
    ".assets/tex/general.bib" = { source = ./assets/tex/bib.bib; };
    ".assets/tex/listings-rust.sty" = { source = ./assets/tex/listings-rust.sty; };
    ".assets/nu/pack.nu" = { source = ./assets/scripts/pack.nu; };
    ".assets/vencord/system24.theme.css" = { source = ./assets/system24.theme.css; };

  };

}
