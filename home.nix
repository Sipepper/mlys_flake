{ config, pkgs, nixpkgs-stable, inputs, lib, ... }:
# let 
#   flake_path = builtins.path { path = ./.; name = "source"; } ;
# in
{ 
  imports = [
    ./default.nix
    ./desktop.nix
    ./file_creation.nix
    ./ui.nix
    ./workspace.nix
  ];

  default.main-font = "Iosevka Nerd Font";
  default.term-font = "Iosevka Term NF";

  home = {
    username = "mlys";
    homeDirectory = "/home/mlys";
    sessionVariables = {
      SHELL = "nu";
      NIXOS_OZONE_WL = 1;
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      # PAGER = "bat --plain";
      PAGER = "bat";
      # MANPAGER = "bat --plain";
      MANPAGER = "bat";

      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
    pointerCursor = config.default.cursor;
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    lutris = {
      enable = true;
      extraPackages = with pkgs; [
        mangohud 
        winetricks
        gamescope
        gamemode
      ];
      protonPackages = [ pkgs.proton-ge-bin ];
    };

    helix.enable = true;
    iamb.enable = true;
    ncspot.enable = true;
    starship.enable = true;
    gh.enable = true;
    # TUI Mail client
    aerc.enable = true; # Config is broken
    fastfetch = {
      enable = true;
      settings = {
        # logo = {
        #   source = ./assets/galana.png;
        #    width = 50;
        #    height = 50;
        #    padding = {
        #      top = 20;
        #      bottom = 20;
        #    };
        # };
        display = {
          separator = " -> ";
          constants = [
            "──────────────────────────────"
          ];
        };
        modules = [
          { type= "custom"; format= "┌{$1}{$1}┐"; outputColor= "90"; }
          { type= "title"; keyWidth= "10"; }
          { type= "custom"; format= "└{$1}{$1}┘"; outputColor= "90"; }
          { type= "custom"; format=  "{#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37}  {#38}  {#39}       {#38}  {#37}  {#36}  {#35}  {#34}  {#33}  {#32}  {#31}  {#90} "; }
          { type= "custom"; format= "┌{$1} {$1}┐"; outputColor= "90"; }
          { type= "os";        key= "{icon} OS"; keyColor= "yellow"; }
          { type= "kernel";    key= "│ ├ ";     keyColor= "yellow"; }
          { type= "packages";  key= "│ ├󰏖 ";     keyColor= "yellow"; }
          { type= "shell";     key= "│ └ ";     keyColor= "yellow"; }
          { type= "wm";        key= " DE/WM";   keyColor= "blue"; }
          { type= "lm";        key= "│ ├󰧨 ";     keyColor= "blue"; }
          { type= "wmtheme";   key= "│ ├󰉼 ";     keyColor= "blue"; }
          { type= "icons";     key= "│ ├󰀻 ";     keyColor= "blue"; }
          { type= "terminal";  key= "│ ├ ";     keyColor= "blue"; }
          { type= "wallpaper"; key= "│ └󰸉 ";     keyColor= "blue"; }
          { type= "host";      key= "󰌢 PC";      keyColor= "green"; }
          { type= "cpu";       key= "│ ├󰻠 ";     keyColor= "green"; }
          { type= "gpu";       key= "│ ├󰍛 ";     keyColor= "green"; }
          { type= "disk";      key= "│ ├ ";     keyColor= "green"; }
          { type= "memory";    key= "│ ├󰑭 ";     keyColor= "green"; }
          { type= "swap";      key= "│ ├󰓡 ";     keyColor= "green"; }
          { type= "uptime";    key= "│ ├󰅐";      keyColor= "green"; }
          { type= "display";   key= "│ └󰍹";      keyColor= "green"; }
          { type= "sound";     key= " SND";     keyColor= "cyan"; }
          { type= "player";    key= "│ ├󰥠 ";     keyColor= "cyan"; }
          { type= "media";     key= "│ └󰝚 ";     keyColor= "cyan"; }
          { type= "custom"; format= "└{$1} {$1}┘"; outputColor= "90"; }
          "break"
        ];
      };
    };
    bat = {
      enable = true;
      config = {
        # pager = "less -FR";
        theme = "Nord";
      };
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--line-number"
        "--smart-case"
      ];
    };

    kitty = {
      enable = true;
      font = {
        name = config.default.term-font;
        size = 12;
      };
      settings = {
        enable_audio_bell = false;
        allow_remote_control = true;
        listen_on = "unix:kitty";
        tab_bar_edge  = "top";
        tab_bar_style = "powerline";
        scrollback_lines = 100000;
        scrollback_pager = "bat --chop-long-lines";
        # cursor_trail = 3;
        enabled_layouts = "all";
        background = "#192330";

        remember_window_size = false;
      };
      themeFile = "Wombat";
    };

    sioyek = {
      enable = true;
      bindings = {
        "move_up_smooth" = "k";
        "move_down_smooth" = "j";
        "move_left" = "l";
        "move_right" = "h";
        "close_window" = "q";
        "quit" = "Q";
        "next_page" = "J";
        "previous_page" = "K";

        "synctex_under_ruler" = "gd";
        "copy" = "yy";
        "visual_mark_under_cursor" = "V";
      };
      config = {
        "should_launch_new_window" = "1";
        "ui_font" = "${config.default.main-font}";
        "font_size" = "12";
        "super_fast_search" = "1";
        "rerender_overview" = "1";
        # "force_custom_line_algorithm" = "1";
        "status_bar_font_size" = "14";
        "inverse_search_command" = "nvim +%2 %1";

      };
    };
    # https://github.com/ahrm/sioyek/blob/main/pdf_viewer/prefs.config
    # https://github.com/ahrm/sioyek/blob/main/pdf_viewer/keys.config
    mangohud.enable = true;

    nushell = {
      enable = true;
      shellAliases = {
        paper = "nu ${./assets/scripts/paper.nu}";
      };
      configFile.text = ''
      $env.config.buffer_editor = "nvim" 
      $env.config.show_banner = false 

      $env.config = {
        bracketed_paste:                  true
        buffer_editor:                    ""
        datetime_format:                  {}
        edit_mode:                        vi
        error_style:                      fancy
        float_precision:                  2
        footer_mode:                      25
        render_right_prompt_on_last_line: false
        show_banner:                      false
        use_ansi_coloring:                true
        use_kitty_protocol:               true
      }
      '';
      # environmentVariables = {
      # };
    };

    feh = {
      enable = true;
      keybindings = {
        menu_parent = "Left";
        menu_child = "Right";
        menu_down	= "Down";
        menu_up =	"Up";

        scroll_left = "h";
        scroll_right = "l";
        scroll_up = "k";
        scroll_down = "j";

        scroll_left_page = "C-h";
        scroll_right_page	= "C-l";
        scroll_up_page = "C-k";
        scroll_down_page = "C-j";

        toggle_aliasing = "A";
        toggle_filenames = "d";
        toggle_pointer = "o";
        toggle_fullscreen	= "f";

        zoom_in = "plus";
        zoom_out = "minus";

        next_img = "greater";
        prev_img = "less";
        reload_image = "r";
        size_to_image = "w";
        next_dir = "bracketright";
        prev_dir = "bracketleft";
        orient_3 = "parenright";
        orient_1 = "parenleft";
        flip = "underscore";
        mirror = "bar";
        remove = "Delete";
        zoom_fit = "s";
        zoom_default = "a";

        close = [
          "q"
          "Q"
        ]; 
      };
    };
  };

  services = {
    # Don't work, cannot get info
    # redshift.enable = true;
    # redshift.provider = "geoclue2";

    easyeffects.enable = true;
    tldr-update.enable = true;
    pass-secret-service.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # SOFT
  home.packages = with pkgs; [
    firefox              # browser
    wofi                 # needed for waybar config, may delete soon TODO
    brightnessctl        # brightness control
    telegram-desktop     # telegram (messenger)
    sioyek               # nvim-esque pdf-reader
    tectonic             # LaTeX processing
    rustc                # Rust programming language
    clippy               # Rust linter
    cargo                # rust package manager
    obsidian             # note taking
    lazygit              # tui git 
    qbittorrent          # torrent client
    inkscape             # vector graphics
    grim                 # screen shots together with slurp
    slurp                # 
    bacon                # Rust "jit" compilation tool
    mpv                  # video player
    pyradio              # tui radio
    feh                  # image viewer
    libreoffice-fresh    # office editors doc,xlsx, etc
    discord              # voice and text-chat app
    gpg-tui              # tui gpg
    kega-fusion          # SEGA emulator
    btop                 # tui system monitor
    timer	         # tui timer
    wf-recorder          # screen capture
    networkmanagerapplet # connections control for waybar
    wasistlos            # whatsapp client
    # sc-controller        # controller configs
    orca-c               # esoteric programming sequencer
    cava                 # audio visualizer
    libremines           # minesweeper
    aseprite             # pixel img/animation drawing software
    pipes-rs             # cli pipes simulation
    wl-color-picker      # color picker
    xournalpp            # More advanced whiteboard
    tldr                 # Offline command Manual, substitute for `man` command
    # osu-lazer-bin        # Rhytm game
    wev                  # wayland event viewer
    hyprpicker           # Another Color picker need further comparison with wl-color-picker
    slack                # Business communication (Discord for KSE)
    gcalcli              # TUI Google Calendar
    prismlauncher        # Minecraft launcher
    lshw                 # Hardware info
    usbutils
    dysk                 # TUI disk storage visualization 
    visidata             # TUI data visualization
    wiki-tui             # TUI wikipedia
    mask                 # Markdown makefiles
    presenterm           # TUI Presentations!
    dust                 # Disk space visualization
    ouch                 # cli archiving tool
    # matrix-commander-rs
    pass-wayland         # cli password store
    tuifeed              # tui news feed reader
    dua                  # tui storage capacity viewer
    bluetuith            # tui bluetooth manager
    clinfo
    evince
    texliveFull          # TODO needed for Inkscape to render LaTeX
    # orca-slicer        # 3D printing slicer
    # freecad-wayland    # CAD software
    # texliveFull
    tree                 # CLI folder visualization
    wine

  ];
}
