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
    ./sync.nix
    ./workspace.nix
  ];

  default.isPC = true;
  default.main-font = "Iosevka Nerd Font";

  home = {
    username = "mlys";
    homeDirectory = "/home/mlys";
    sessionVariables = {
      SHELL = "nu";
      NIXOS_OZONE_WL = 1;
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      PAGER = "bat --plain";
      MANPAGER = "bat --plain";

      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
    pointerCursor = config.default.cursor;
  };


  programs.helix.enable = true;

  programs.iamb = {
    enable = true;
    # settings = {
    #   profiles = {
    #     default_profile = "personal";
    #   };
    #   settings = {
    #     notifications.enabled = true;
    #     image_preview.protocol = {
    #       type = "kitty";
    #       size = {
    #         height = 10;
    #         width = 66;
    #       };
    #     };
    #   };
    # };
  };

  programs.ncspot.enable = true;

  programs.starship.enable = true;

  programs.gh.enable = true;

  # TUI Mail client
  programs.aerc.enable = true;
  # Config is broken

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = ./assets/endeminis-icon.png;
        padding = {
          right = 1;
        };
      };
      display = {
        size = {
          binaryPrefix = "si";
        };
        color = "blue";
        separator = "  ";
      };
      modules = [
        {
          type = "datetime";
          key = "Date";
          format = "{1}-{3}-{11}";
        }
        {
          type = "datetime";
          key = "Time";
          format = "{14}:{17}:{20}";
        }
        "break"
        "player"
        "media"
      ];
    };
  };

  # programs.qutebrowser.enable = true;
  # programs.qutebrowser = {
  #   quickmarks = {
  #     nixpkgs = "https://github.com/NixOS/nixpkgs";
  #     home-manager = "https://github.com/nix-community/home-manager";
  #   };
  #   settings = {
  #     colors = {
  #       hints = {
  #         bg = "#${config.default.colors.background}";
  #         fg = "#${config.default.colors.text}";
  #       };
  #       tabs.bar.bg = "#${config.default.colors.background}";
  #     };
  #     tabs.tabs_are_windows = true;
  #   };
  # };

  programs.bat.enable = true;
  programs.bat = {
    config = {
      # pager = "less -FR";
      theme = "Nord";
    };
  };

  programs.ripgrep.enable = true;
  programs.ripgrep = {
    arguments = [
      "--line-number"
      "--smart-case"
    ];
  };

  programs.wezterm.enable = true;
  programs.ghostty.enable = true;

  programs.kitty = {
    enable = true;
    font = {
      name = config.default.main-font;
      # size = if config.default.isPC then 12 else 10;
      size = 10;
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

  programs.sioyek = {
    enable = true;
    bindings = {
      "move_up_smooth" = "k";
      "move_down_smooth" = "j";
      "move_left" = "l";
      "move_right" = "h";
      "close_window" = "q";
      "quit" = "Q";

      "synctex_under_ruler" = "gd";
      "copy" = "yy";
      "visual_mark_under_cursor" = "V";
    };
    config = {
      # "should_launch_new_window" = "1";
      "ui_font" = "${config.default.main-font}";
      "font_size" = "12";
      "super_fast_search" = "1";
      "rerender_overview" = "1";
      # "linear_filter" = "1";
      "force_custom_line_algorithm" = "1";
      "status_bar_font_size" = "14";
      # "inverse_search_command" = "kitty -e \"nvim +%2 %1\"";

    };
  };
  # https://github.com/ahrm/sioyek/blob/main/pdf_viewer/prefs.config
  # https://github.com/ahrm/sioyek/blob/main/pdf_viewer/keys.config

  services = {
  # Don't work, cannot get info
    redshift.enable = true;
    redshift.provider = "geoclue2";

    easyeffects.enable = true;
    tldr-update.enable = true;
  };


  programs.mangohud.enable = true;

  programs.nushell.enable = true;
  programs.nushell = {
    shellAliases = {
      # TODO not working
      # rebuild = "nu ${./assets/scripts/rebuild.nu} ${./.}";

      texenpaper = "nu ${./assets/scripts/paper.nu}";
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

  programs.feh = {
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
    syncthing            # p2p file sync between devices
    inkscape             # vector graphics
    grim                 # screen shots together with slurp
    slurp                # 
    bacon                # Rust "jit" compilation tool
    mpv                  # video player
    pyradio              # tui radio
    feh                  # image viewer

    libreoffice-fresh    # office editors doc,xlsx, etc
    discord              # voice and text-chat app
    smassh               # tui typing training
    gpg-tui              # tui gpg
    kega-fusion          # SEGA emulator
    btop                 # tui system monitor
    timer	         # tui timer
    wf-recorder          # screen capture
    networkmanagerapplet # connections control for waybar
    wasistlos            # whatsapp client
    sc-controller        # controller configs
    atool                # needed for archive zipping un zipping in ranger 
    # highlight            # ranger file preview highlight
    orca-c               # esoteric programming sequencer
    cava                 # audio visualizer
    libremines           # minesweeper
    lutris               # unified game launcher proton/wine wrapper
    aseprite             # pixel img/animation drawing software
    pipes-rs             # cli pipes simulation
    wl-color-picker      # color picker
    xournalpp            # More advanced whiteboard
    tldr                 # Offline command Manual, substitute for `man` command
    osu-lazer-bin        # Rhytm game
    wev
    hyprpicker           # Another Color picker need further comparison with wl-color-picker
    slack                # Business communication (Discord for KSE)
    gcalcli              # TUI Google Calendar
    prismlauncher        # Minecraft launcher
    w3m-nox
    lshw                 # Hardware info
    usbutils
    celestia             # GUI space exploration encyclopedia
    dysk                 # TUI disk storage visualization 
    visidata             # TUI data visualization
    wiki-tui             # TUI wikipedia
    mask                 # Markdown makefiles
    presenterm           # TUI Presentations!
    dust                 # Disk space visualization
    ouch                 # cli archiving tool
    matrix-commander-rs
    # nheko
    pass-wayland
    tuifeed
    # chawan
    lynx
    links2
    dua
    bluetuith
    clinfo
    evince
    texliveFull

  ] ++ (if config.default.isPC then [
      # PC Soft
      # orca-slicer        # 3D printing slicer
      # protonup
      # wine-wayland
      # winetricks
      # freecad-wayland    # CAD software
    ] else []);

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
