{ config, pkgs, ... }:
{
  imports = [
    ./default.nix
    ./desktop.nix
    ./file_creation.nix
    ./ui.nix
    ./workspace.nix
  ];

  default.main-font = "Iosevka Custom";
  default.term-font = "IosevkaTerm NF";

  home = {
    username = "mlys";
    homeDirectory = "/home/mlys";
    sessionVariables = {
      SHELL = "nu";
      NIXOS_OZONE_WL = 1;
      EDITOR = "hx";
      BROWSER = "firefox";
      TERMINAL = "wezterm";
      PAGER = "bat";
      MANPAGER = "bat";
    };
    pointerCursor = config.default.cursor;
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

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
        #   # type = "sixel";
        #   width = 20;
        #   height = 20;
        #   padding = {
        #     top = 10;
        #     bottom = 10;
        #   };
        # };
        display = {
          separator = " -> ";
          constants = [
            "──────────────────────────────"
          ];
        };
        modules = [
          {
            type = "custom";
            format = "┌{$1} {$1}┐";
            outputColor = "90";
          }
          {
            type = "title";
            keyWidth = "10";
          }
          {
            type = "custom";
            format = "└{$1} {$1}┘";
            outputColor = "90";
          }
          {
            type = "custom";
            format = "{#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37}  {#38}  {#39}       {#38}  {#37}  {#36}  {#35}  {#34}  {#33}  {#32}  {#31}  {#90} ";
          }
          {
            type = "custom";
            format = "┌{$1} {$1}┐";
            outputColor = "90";
          }
          {
            type = "os";
            key = "{icon} OS";
            keyColor = "yellow";
          }
          {
            type = "kernel";
            key = "│ ├ ";
            keyColor = "yellow";
          }
          {
            type = "packages";
            key = "│ ├󰏖 ";
            keyColor = "yellow";
          }
          {
            type = "shell";
            key = "│ └ ";
            keyColor = "yellow";
          }
          {
            type = "wm";
            key = " DE/WM";
            keyColor = "blue";
          }
          {
            type = "lm";
            key = "│ ├󰧨 ";
            keyColor = "blue";
          }
          {
            type = "wmtheme";
            key = "│ ├󰉼 ";
            keyColor = "blue";
          }
          {
            type = "icons";
            key = "│ ├󰀻 ";
            keyColor = "blue";
          }
          {
            type = "terminal";
            key = "│ ├ ";
            keyColor = "blue";
          }
          {
            type = "wallpaper";
            key = "│ └󰸉 ";
            keyColor = "blue";
          }
          {
            type = "host";
            key = "󰌢 PC";
            keyColor = "green";
          }
          {
            type = "cpu";
            key = "│ ├󰻠 ";
            keyColor = "green";
          }
          {
            type = "gpu";
            key = "│ ├󰍛 ";
            keyColor = "green";
          }
          {
            type = "disk";
            key = "│ ├ ";
            keyColor = "green";
          }
          {
            type = "memory";
            key = "│ ├󰑭 ";
            keyColor = "green";
          }
          {
            type = "swap";
            key = "│ ├󰓡 ";
            keyColor = "green";
          }
          {
            type = "uptime";
            key = "│ ├󰅐";
            keyColor = "green";
          }
          {
            type = "display";
            key = "│ └󰍹";
            keyColor = "green";
          }
          {
            type = "sound";
            key = " SND";
            keyColor = "cyan";
          }
          {
            type = "player";
            key = "│ ├󰥠 ";
            keyColor = "cyan";
          }
          {
            type = "media";
            key = "│ └󰝚 ";
            keyColor = "cyan";
          }
          {
            type = "custom";
            format = "└{$1} {$1}┘";
            outputColor = "90";
          }
          "break"
        ];
      };
    };
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "TwoDark";
      };
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--line-number"
        "--smart-case"
      ];
    };

    sioyek = {
      enable = true;
      bindings = {
        move_up_smooth = "k";
        move_down_smooth = "j";
        move_left = "l";
        move_right = "h";
        close_window = "q";
        quit = "Q";
        next_page = "J";
        previous_page = "K";
        synctex_under_ruler = "gd";
        copy = "yy";
        visual_mark_under_cursor = "V";
      };
      config = {
        should_launch_new_window = "1";
        ui_font = "${config.default.main-font}";
        font_size = "14";
        keyboard_select_font_size = "10";
        super_fast_search = "1";
        rerender_overview = "1";
        status_bar_font_size = "16";
        inverse_search_command = "hx %1:%2";

      };
    };
    # https://github.com/ahrm/sioyek/blob/main/pdf_viewer/prefs.config
    # https://github.com/ahrm/sioyek/blob/main/pdf_viewer/keys.config

    nushell = {
      enable = true;
      shellAliases = {
        paper = "nu ${./assets/scripts/paper.nu}";
        paper2 = "nu ${./assets/scripts/paper2.nu}";
        note = "nu ${./assets/scripts/note.nu}";
      };
      configFile.text = ''
        $env.config.buffer_editor = "helix" 
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
          }
      '';
      environmentVariables = {
        YAZI_TEMP = "~/.yazi_temp";
      };
    };

    feh = {
      enable = true;
      keybindings = {
        menu_parent = "Left";
        menu_child = "Right";
        menu_down = "Down";
        menu_up = "Up";

        scroll_left = "h";
        scroll_right = "l";
        scroll_up = "k";
        scroll_down = "j";

        scroll_left_page = "C-h";
        scroll_right_page = "C-l";
        scroll_up_page = "C-k";
        scroll_down_page = "C-j";

        toggle_aliasing = "A";
        toggle_filenames = "d";
        toggle_pointer = "o";
        toggle_fullscreen = "f";

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
    clipse = {
      enable = true;
      imageDisplay = {
        type = "sixel";
        heightCut = 10;
      };
    };

    gammastep = {
      enable = true;
      provider = "geoclue2";
      tray = true;
      temperature = {
        day = 6500;
        night = 4000;
      };
    };

    easyeffects = {
      enable = true;
      preset = "standard_home";
      extraPresets = {
        standard_home = {
          input = {
            "autogain#0" = {
              bypass = false;
              force-silence = false;
              input-gain = 0;
              maximum-history = 15;
              output-gain = -5;
              reference = "Geometric Mean (MSI)";
              silence-threshold = -70;
              target = -24;
            };
            blocklist = [

            ];
            "exciter#0" = {
              amount = 0;
              blend = 0;
              bypass = false;
              ceil = 16000;
              ceil-active = false;
              harmonics = {
              };
              input-gain = 0;
              output-gain = 0;
              scope = 7500;
            };
            plugins_order = [
              "rnnoise#0"
              "speex#0"
              "exciter#0"
              "autogain#0"
            ];
            "rnnoise#0" = {
              bypass = false;
              enable-vad = false;
              input-gain = 0;
              model-name = "\"\"";
              output-gain = 0;
              release = 20;
              use-standard-model = true;
              vad-thres = 50;
              wet = 0;
            };
            "speex#0" = {
              bypass = false;
              enable-agc = true;
              enable-denoise = false;
              enable-dereverb = true;
              input-gain = 0;
              noise-suppression = -1;
              output-gain = 0;
              vad = {
                enable = true;
                probability-continue = 90;
                probability-start = 95;
              };
            };
          };
        };
      };
    };
    tldr-update.enable = true;
    pass-secret-service.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # SOFT
  home.packages = [
    pkgs.wofi # needed for waybar config, may delete soon TODO
    pkgs.brightnessctl # brightness control
    pkgs.telegram-desktop # telegram (messenger)
    pkgs.tectonic # LaTeX processing
    pkgs.rustc # Rust programming language
    pkgs.clippy # Rust linter
    pkgs.cargo # rust package manager
    pkgs.nyaa # tui torrents browser & download
    pkgs.inkscape # vector graphics
    pkgs.grim # screen shots together with slurp
    pkgs.slurp
    pkgs.bacon # Rust "jit" compilation tool
    pkgs.mpv # video player
    pkgs.pyradio # tui radio
    pkgs.feh # image viewer
    pkgs.libreoffice-fresh # office editors doc,xlsx, etc
    pkgs.wf-recorder # screen capture
    pkgs.networkmanagerapplet # connections control for waybar
    pkgs.wasistlos # whatsapp client
    pkgs.xournalpp # More advanced whiteboard
    pkgs.tldr # Offline command Manual, substitute for `man` command
    pkgs.wev # wayland event viewer
    pkgs.hyprpicker # Another Color picker need further comparison with wl-color-picker
    pkgs.prismlauncher # Minecraft launcher
    pkgs.lshw # Hardware info
    pkgs.usbutils
    pkgs.presenterm # TUI Presentations!
    pkgs.dust # Disk space visualization
    pkgs.ouch # cli archiving tool
    pkgs.pass-wayland # cli password store
    pkgs.dua # tui storage capacity viewer
    pkgs.bluetuith # tui bluetooth manager
    pkgs.evince # DJVU/PDF reader
    pkgs.tree # CLI folder visualization
    pkgs.woomer # Screen zoom and focus like Tsoding | TODO not working with fractional scaling
    pkgs.mermaid-cli # Mermaid diagrams
    pkgs.typst # Better LaTeX
    pkgs.jq # CLI json processor
    pkgs.cargo-generate # Generate Rust project template based on git repo
    pkgs.cargo-expand
    pkgs.cargo-fuzz
    pkgs.milkytracker # Tracker DAW
    pkgs.tilinggallery # Penrose tiling wallpaper generator
    pkgs.wbg # Replacement for hyprpaper
    pkgs.chawan
    pkgs.jdk25
    pkgs.lazyjj
    pkgs.zola
    pkgs.hayabusa
    pkgs.pipes-rs # cli pipes simulation
    # pkgs.aseprite # pixel img/animation drawing software
    # pkgs.gpg-tui # tui gpg
    # pkgs.kega-fusion # SEGA emulator
    # pkgs.wiki-tui # TUI wikipedia
    # pkgs.mask # Markdown makefiles
    # pkgs.tuifeed # tui news feed reader
    # pkgs.texliveFull # TODO needed for Inkscape to render LaTeX
    # pkgs.calcure # TUI calendar
    # pkgs.bibtex-tidy # Tidying bibtex offline!
    # sc-controller        # controller configs
    # orca-c               # esoteric programming sequencer
    # cava                 # audio visualizer
    # libremines           # minesweeper
    # osu-lazer-bin        # Rhytm game
    # gcalcli              # TUI Google Calendar
    # matrix-commander-rs
    # orca-slicer          # 3D printing slicer
    # freecad-wayland      # CAD software
    # gearlever            # to work with Appimages
    # dysk                 # TUI disk storage visualization
    # visidata             # TUI data visualization
  ];
}
