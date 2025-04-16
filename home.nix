{ config, pkgs, nixpkgs-stable, inputs, lib, ... }:
{ 
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./default.nix
    ./waybar.nix
    # ./xplr.nix
    # ./gtk_home.nix
  ];

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
      GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/glib-2.0/schemas";
      LD_LIBRARY_PATH = "\$\{LD_LIBRARY_PATH\}:${ pkgs.lib.makeLibraryPath [ pkgs.vulkan-loader ] }";
    };
    pointerCursor = config.default.cursor;
  };

  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  ];
  
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    # config = {
    #   common.default = [ "gtk" "termfilechooser" ];
    #   hyprland.default = [ "termfilechooser" "gtk" "hyprland" ];
    #   qt5.default = [ "gtk" "termfilechooser" ];
    # };
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk 
      pkgs.xdg-desktop-portal-termfilechooser
      pkgs.xdg-desktop-portal-hyprland 
    ];
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

  programs.gh.enable = true;

  # TUI File manager
  programs.xplr.enable = true;
  programs.xplr = {
    plugins = {
      wl-clipboard = pkgs.fetchFromGitHub {
        owner = "sayanarijit";
        repo = "wl-clipboard.xplr";
        rev = "a3ffc87460c5c7f560bffea689487ae14b36d9c3";
        hash = "sha256-I4rh5Zks9hiXozBiPDuRdHwW5I7ppzEpQNtirY0Lcks=";
      };
      zentable = pkgs.fetchFromGitHub {
        owner = "dy-sh";
        repo = "dysh-style.xplr";
        rev = "12dab25f9410e1c67f09f60c0af030ea5210ea0d";
        hash = "sha256-Neh9Rbr6kFqEFQsdOQUutqZeVTJ5ELP7DzY7f4GXyZk=";
      };
      # zentable = fetchFromGitHub {};
      # zentable = fetchFromGitHub {};
    };
    extraConfig = ''
      require("wl-clipboard").setup()
      require("zentable").setup()
    '';
  };

  # TUI Mail client
  programs.aerc.enable = true;
  # Config is broken

  programs.qutebrowser.enable = true;
  programs.qutebrowser = {
    quickmarks = {
      nixpkgs = "https://github.com/NixOS/nixpkgs";
      home-manager = "https://github.com/nix-community/home-manager";
    };
    settings = {
      colors = {
        hints = {
          bg = "#${config.default.colors.background}";
          fg = "#${config.default.colors.text}";
        };
        tabs.bar.bg = "#${config.default.colors.background}";
      };
      tabs.tabs_are_windows = true;
    };
  };

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

  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      font = config.default.main-font;
      terminal = "kitty -e";
      horizontal-pad = 8;
      vertical-pad = 4;
      icon-theme = config.default.iconTheme.name;
    };
    colors = {
      background = "${config.default.colors.background}ff";
      text = "${config.default.colors.text}ff";
      border = "${config.default.colors.border}ff";
    };
    border = {
      width = 2;
      radius = 0;
    };
  };


  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    colorschemes.nightfox.enable = true;
    extraPlugins = [
      pkgs.tree-sitter-grammars.tree-sitter-nu
    ];

    globals.mapleader = " ";

    opts = {
      smartcase = true;
      ignorecase = true;
      number = true;
      relativenumber = true;
      completeopt = ["menu" "menuone" "noselect"];
      clipboard = "unnamedplus";
      foldenable = false;

      shiftwidth = 2;
      langmap = "ФИСВУАПРШОЛДЬТЩЗЙКІЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкіегмцчня;abcdefghijklmnopqrstuvwxyz,хїґжєбю\\ʼ;\\[\\]\\\\;\\'\\,\\.\\~";
    };
    keymaps = [
      {
        action = "<C-w>l";
        key = "<C-l>";
        options.desc = "sd1";
      }
      {
        action = "<C-w>h";
        key = "<C-h>";
        options.desc = "sd4";
      }
      {
        action = "<C-w>j";
        key = "<C-j>";
        options.desc = "sd3";
      }
      {
        action = "<C-w>k";
        key = "<C-k>";
        options.desc = "sd2";
      }
      {
        action = "<cmd>noh<CR>";
        key = "<Esc><Esc>";
        options.desc = "which_key_ignore";
      }
      {
        action = "<cmd>BufferLineCloseOthers<CR>";
        key = "<leader>bo";
        options.desc = "Close other buffers";
      }
      {
        action = "<cmd>bdelete<CR>";
        key = "<leader>bd";
        options.desc = "Close buffer";
      }
      {
        action = "<cmd>bnext<CR>";
        key = "<S-l>";
        options.desc = "Move to right tab";
      }
      {
        action = "<cmd>bprev<CR>";
        key = "<S-h>";
        options.desc = "Move to left tab";
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>g";
        options.desc = "Live Grep";
      }
      {
        action = "<cmd>LazyGitCurrentFile<CR>";
        key = "<leader>lg";
        options.desc = "LazyGit";
      }
      {
        action = "<cmd>CHADopen<cr>";
        key = "<leader>e";
        options.desc = "File Tree";
      }
      {
        action = "<cmd>wq<CR>";
        key = "<leader>qq";
        options.desc = "Save and quit";
      }
      {
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        key = "gd";
        options = {
          noremap = true;
          silent = true;
          desc = "Go to definition";
        };
      }
      {
        action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
        key = "gD";
        options = {
          noremap = true;
          silent = true;
          desc = "Go to declaration";
        };
      }
    ];

    plugins = {
      nix.enable = true;
      web-devicons.enable = true;
      lualine.enable = true;
      luasnip.enable = true;
      telescope.enable = true;
      bacon.enable = true;
      bufferline.enable = true;
      bufferline.settings = {
        options.always_show_bufferline = false;
      };
      nvim-autopairs.enable = true;
      which-key.enable = true;
      colorizer.enable = true;
      colorizer.settings.user_default_options = {
        AARRGGBB = true;
        RRGGBBAA = true;
        RGB = true;
        names = false;
      };

      indent-blankline.enable = true;
      indent-blankline.settings = {
        exclude = {
          buftypes = [
            "terminal"
            "quickfix"
            "dashboard"
          ];
          filetypes = [
            ""
            "checkhealth"
            "help"
            "lspinfo"
            "packer"
            "TelescopePrompt"
            "TelescopeResults"
            "yaml"
            "dashboard"
          ];
        };
        indent.char = "│";
      };

      lazygit.enable = true;
      lazygit.settings = {
        floating_window_border_chars = [
          "┌"
          "─"
          "┐"
          "│"
          "┘"
          "─"
          "└"
          "│"
        ];
      };
      noice.enable = true;

      dashboard.enable = true;
      dashboard.settings = {
        change_to_vcs_root = true;
        config = {
          footer = [
            "Violence is the last refuge of the incompetent!"
          ];
          header = [
            "██████╗  ██████╗ ██████╗ ███████╗ █████╗ ██╗     ██╗███████╗"
            "██╔══██╗██╔═══██╗██╔══██╗██╔════╝██╔══██╗██║     ██║██╔════╝"
            "██████╔╝██║   ██║██████╔╝█████╗  ███████║██║     ██║███████╗"
            "██╔══██╗██║   ██║██╔══██╗██╔══╝  ██╔══██║██║     ██║╚════██║"
            "██████╔╝╚██████╔╝██║  ██║███████╗██║  ██║███████╗██║███████║"
            "╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝"
          ];
          mru = {
            limit = 8;
          };
          project = {
            enable = false;
          };
          shortcut = [
            {
              action = {
                __raw = "function(path) vim.cmd('Telescope find_files') end";
              };
              desc = "Files";
              group = "Label";
              icon = " ";
              icon_hl = "@variable";
              key = "f";
            }
            {
              action = "q";
              desc = " quit";
              group = "Number";
              key = "q";
            }
          ];
          week_header = { enable = false; };
        };
        theme = "hyper";
      };
      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          quick_lint_js = {
            enable = true;
          };
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          texlab.enable = true;
          # nixd.enable = true;
          nushell.enable = true;
          html.enable = true;
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
            {name = "luasnip";}
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };

      treesitter = {
        enable = true;
        settings = {
          highlight = {
            enable = true;
            disable = [ "latex" ];
            additional_vim_regex_highlighting = true;
          };
          indent.enable = true;
        };
      };
      # neo-tree = { enable = true; };
      chadtree = {
        enable = true;
        theme.textColourSet = "nord";
        view.openDirection = "right";
      };

      vimtex = {
        enable = true;
        texlivePackage = pkgs.texlive.combined.scheme-full;
        settings = {
          compiler_method = "tectonic";
          compiler.tectonic = {
            options = [ "--synctex" ];
          };
          toc_config = { 
            split_pos = "vert topleft";   # TODO 
            split_width = 40;
          };
          view_method = "sioyek";
          imaps = {
            disabled = [];
            list = [
              "fr \\fraction\{\}\{\}"
            ];
          };
          mappings.disable = {
            "n" = ["tse" "tsd"];
            "x" = ["tsd"];
          };
          matchparen.enable = true;
          quickfix_autojump = true;
          syntax_conceal_disable = true;
        };
      };
      toggleterm.enable = true;
      toggleterm.settings = {
        direction = "float";
        float_opts = {
          border = "single";
          height = 30;
          width = 130;
        };
        open_mapping = "[[<c-/>]]";
      };
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = config.default.main-font;
      size = 10;
    };
    settings = {
      enable_audio_bell = false;
      allow_remote_control = true;
      tab_bar_edge  = "top";
      tab_bar_style = "powerline";
      scrollback_lines = 100000;
      scrollback_pager = "bat --chop-long-lines";
      # cursor_trail = 3;

      window_margin_width = 0;
      window_border_width = 0;
      remember_window_size = false;
      draw_minimal_borders = false;
    };
    themeFile = "Wombat";
  };

  programs.git = {
    enable = true;
    userName = "Sipepper";
    userEmail = "valera1gribnik@gmail.com";
  };

  programs.ranger = {
    enable = true;
    plugins = [ ];
    settings = {
      viewmode = "miller";
      column_ratios = "1,3,4";
      hidden_filter = "^\\.|\\.(?:pyc|pyo|bak|swp)$|^lost\\+found$|^__(py)?cache__$";
      show_hidden = false;
      confirm_on_delete = "never";
      use_preview_script = true;
      automatically_count_files = true;
      open_all_images = true;
      vcs_aware = false;
      vcs_backend_git= "enabled";
      vcs_backend_hg = "disabled";
      vcs_backend_bzr= "disabled";
      vcs_backend_svn= "disabled";
      vcs_msg_length = "50";
      preview_images_method = "kitty";
      preview_images = true;
      w3m_delay = "0.02";
      w3m_offset = "0";
      unicode_ellipsis = false;
      show_hidden_bookmarks = true;
      colorscheme = "default";
      preview_files = true;
      preview_directories = true;
      collapse_preview = true;
      wrap_plaintext_previews = false;
      save_console_history = true;
      status_bar_on_top = false;
      draw_progress_bar_in_status_bar = true;
      draw_borders = "none";
      dirname_in_tabs = false;
      mouse_enabled = true;
      display_size_in_main_column = true;
      display_size_in_status_bar = true;
      display_free_space_in_status_bar = true;
      display_tags_in_all_columns = true;
      update_title = false;
      update_tmux_title = true;
      shorten_title = "3";
      hostname_in_titlebar = true;
      tilde_in_titlebar = false;
      max_history_size = "20";
      max_console_history_size = "50";
      scroll_offset = "8";
      flushinput = true;
      padding_right = true;
      autosave_bookmarks = true;
      save_backtick_bookmark = true;
      autoupdate_cumulative_size = false;
      show_cursor = false;
      sort = "natural";
      sort_reverse = false;
      sort_case_insensitive = true;
      sort_directories_first = true;
      sort_unicode = false;
      xterm_alt_key = false;
      cd_bookmarks = true;
      cd_tab_case = "sensitive";
      cd_tab_fuzzy = false;
      preview_max_size = "0";
      hint_collapse_threshold = "10";
      show_selection_in_titlebar = true;
      idle_delay = "2000";
      metadata_deep_search = false;
      clear_filters_on_dir_change = false;
      line_numbers = "relative";
      relative_current_zero = true;
      one_indexed = false;
      save_tabs_on_exit = false;
      wrap_scroll = false;
      global_inode_type_filter = "";
      freeze_files = false;
      size_in_bytes = false;
      nested_ranger_warning = true;
    };
    aliases = {
      # e     = "edit";
      q     = "quit";
      "q!"    = "quit!";
      setl  = "setlocal";

      filter    = "scout -prts";
      hide      = "scout -prtsv";
      find      = "scout -aets";
      mark      = "scout -mr";
      unmark    = "scout -Mr";
      search    = "scout -rs";
      search_inc= "scout -rts";
      travel    = "scout -aefklst";
    };
    mappings = {
      xc = "shell %p | $\"file://($in)\" | wl-copy -t text/uri-list";
      Q = "quitall";
      q = "quit";
      R     = "reload_cwd";
      F     = "reset freeze_files!";
      "<C-r>" = "reset";
      "<C-l>" = "redraw_window";
      "<C-c>" = "abort";
      "<esc>" = "change_mode normal";

      i = "display_file";
      "<A-j>" = "scroll_preview 1";
      "<A-k>" = "scroll_preview -1";
      "?" = "help";
      W = "display_log";
      w = "taskview_open";
      S = "shell $env.SHELL";

      ":"  = "console";
      ";"  = "console";
      "!"  = "console shell%space";
      "@"  = "console -p6 shell  %%s";
      #  = "console shell -p%space";
      s  = "console shell%space";
      r  = "chain draw_possible_programs; console open_with%space";
      f  = "console find%space";
      cd = "console cd%space";
      "<C-p>" = "chain console; eval fm.ui.console.history_move(-1)";

      # Change the line mode
      Mf = "linemode filename";
      Mi = "linemode fileinfo";
      Mm = "linemode mtime";
      Mh = "linemode humanreadablemtime";
      Mp = "linemode permissions";
      Ms = "linemode sizemtime";
      MH = "linemode sizehumanreadablemtime";
      Mt = "linemode metatitle";
      # Tagging / Marking
      t       = "tag_toggle";
      ut      = "tag_remove";
      # "<any>"''  = "tag_toggle tag=%any";
      "<Space>" = "mark_files toggle=True";
      v       = "mark_files all=True toggle=True";
      uv      = "mark_files all=True val=False";
      V       = "toggle_visual_mode";
      uV      = "toggle_visual_mode reverse=True";
      # For the nostalgics: Midnight Commander bindings
      "<F1> " = "help";
      "<F2> " = "rename_append";
      "<F3> " = "display_file";
      "<F4> " = "edit";
      "<F5> " = "copy";
      "<F6> " = "cut";
      "<F7> " = "console mkdir%space";
      "<F8> " = "console delete";
      "<F10>" = "exit";
      k       = "move up=1";
      j       = "move down=1";
      h       = "move left=1";
      l       = "move right=1";
      gg      = "move to=0";
      G       = "move to=-1";
      "<C-F>" = "move down=1   pages=True";
      "<C-B>" = "move up=1     pages=True";
      "<CR>"  = "move right=1";
      # <DELETE>   console delete
      "<INSERT>" = "console touch%space";
      J = "move down=0.5  pages=True";
      K = "move up=0.5    pages=True";

      # Jumping around
      H = "history_go -1";
      L = "history_go 1";
      "]" = "move_parent 1";
      "[" = "move_parent -1";
      "}" = "traverse";
      "{" = "traverse_backwards";
      ")" = "jump_non";

      gh = "cd ~";
      ge = "cd /etc";
      gu = "cd /usr";
      gd = "cd /dev";
      gl = "cd -r .";
      gL = "cd -r %f";
      go = "cd /opt";
      gv = "cd /var";
      gm = "cd /media";
      gi = "eval fm.cd('/run/media/' + os.getenv('USER'))";
      gM = "cd /mnt";
      gs = "cd /srv";
      gp = "cd /tmp";
      gr = "cd /";
      gR = "eval fm.cd(ranger.RANGERDIR)";
      "g/" = "cd /";
      "g?" = "cd /nix/store/y3hhlv0vq6b3vj678dnbs0621mhy7q3l-ranger-1.9.3-unstable-2023-08-23/share/doc/ranger";

      # External Programs
      E    = "edit";
      du   = ''shell -p du -d 1 -h "$(2>/dev/null >&2 du --apparent-size /dev/null && printf '%s\n' --apparent-size || printf '%s\n' --)"'';
      dU   = ''shell -p du -d 1 -h "$(2>/dev/null >&2 du --apparent-size /dev/null && printf '%s\n' --apparent-size || printf '%s\n' --)" | sort -rh'';
      yp   = "yank path";
      yd   = "yank dir";
      yn   = "yank name";
      "y." = "yank name_without_extension";
      # Filesystem Operations
      "=" = "chmod";

      cw = "console rename%space";
      a = "rename_append";
      A = ''eval fm.open_console('rename ' + fm.thisfile.relative_path.replace("%", "%%"))'';
      I = ''eval fm.open_console('rename ' + fm.thisfile.relative_path.replace("%", "%%"), position=7)'';
      pp  = "paste";
      po  = "paste overwrite=True";
      pP  = "paste append=True";
      pO  = "paste overwrite=True append=True";
      pl  = "paste_symlink relative=False";
      pL  = "paste_symlink relative=True";
      phl = "paste_hardlink";
      pht = "paste_hardlinked_subtree";
      pd  = "console paste dest=";
      "p`<any>" = "paste dest=%any_path";
      "p'<any>" = "paste dest=%any_path";
      dD = "console delete";
      dT = "console trash";
      dd = "cut";
      ud = "uncut";
      da = "cut mode=add";
      dr = "cut mode=remove";
      dt = "cut mode=toggle";
      yy = "copy";
      uy = "uncut";
      ya = "copy mode=add";
      yr = "copy mode=remove";
      yt = "copy mode=toggle";
      # Temporary workarounds
      dgg = "eval fm.cut(dirarg=dict(to=0), narg=quantifier)";
      dG  = "eval fm.cut(dirarg=dict(to=-1), narg=quantifier)";
      dj  = "eval fm.cut(dirarg=dict(down=1), narg=quantifier)";
      dk  = "eval fm.cut(dirarg=dict(up=1), narg=quantifier)";
      ygg = "eval fm.copy(dirarg=dict(to=0), narg=quantifier)";
      yG  = "eval fm.copy(dirarg=dict(to=-1), narg=quantifier)";
      yj  = "eval fm.copy(dirarg=dict(down=1), narg=quantifier)";
      yk  = "eval fm.copy(dirarg=dict(up=1), narg=quantifier)";
      # Searching
      "/"  = "console search%space";
      n    = "search_next";
      N    = "search_next forward=False";
      ct   = "search_next order=tag";
      cs   = "search_next order=size";
      ci   = "search_next order=mimetype";
      cc   = "search_next order=ctime";
      cm   = "search_next order=mtime";
      ca   = "search_next order=atime";
      # Tabs
      "<C-n>"       = "tab_new";
      "<C-w>"       = "tab_close";
      "<TAB>"       = "tab_move 1";
      "<S-TAB>"     = "tab_move -1";
      "<A-Right>"   = "tab_move 1";
      "<A-Left>"    = "tab_move -1";
      gt            = "tab_move 1";
      gT            = "tab_move -1";
      gn            = "tab_new";
      gc            = "tab_close";
      uq            = "tab_restore";
      "<a-1>"       = "tab_open 1";
      "<a-2>"       = "tab_open 2";
      "<a-3>"       = "tab_open 3";
      "<a-4>"       = "tab_open 4";
      "<a-5>"       = "tab_open 5";
      "<a-6>"       = "tab_open 6";
      "<a-7>"       = "tab_open 7";
      "<a-8>"       = "tab_open 8";
      "<a-9>"       = "tab_open 9";
      "<a-r>"       = "tab_shift 1";
      "<a-l>"       = "tab_shift -1";
      # Sorting
      or = "set sort_reverse!";
      oz = "set sort=random";
      os = "chain set sort=size;      set sort_reverse=False";
      ob = "chain set sort=basename;  set sort_reverse=False";
      on = "chain set sort=natural;   set sort_reverse=False";
      om = "chain set sort=mtime;     set sort_reverse=False";
      oc = "chain set sort=ctime;     set sort_reverse=False";
      oa = "chain set sort=atime;     set sort_reverse=False";
      ot = "chain set sort=type;      set sort_reverse=False";
      oe = "chain set sort=extension; set sort_reverse=False";
      oS = "chain set sort=size;      set sort_reverse=True";
      oB = "chain set sort=basename;  set sort_reverse=True";
      oN = "chain set sort=natural;   set sort_reverse=True";
      oM = "chain set sort=mtime;     set sort_reverse=True";
      oC = "chain set sort=ctime;     set sort_reverse=True";
      oA = "chain set sort=atime;     set sort_reverse=True";
      oT = "chain set sort=type;      set sort_reverse=True";
      oE = "chain set sort=extension; set sort_reverse=True";
      dc = "get_cumulative_size";
      # Settings
      zc = "set collapse_preview!";
      zd = "set sort_directories_first!";
      zh = "set show_hidden!";
      zI = "set flushinput!";
      zi = "set preview_images!";
      zm = "set mouse_enabled!";
      zp = "set preview_files!";
      zP = "set preview_directories!";
      zs = "set sort_case_insensitive!";
      zu = "set autoupdate_cumulative_size!";
      zv = "set use_preview_script!";
      zf = "console filter%space";
      ".d" = "filter_stack add type d";
      ".f" = "filter_stack add type f";
      ".l" = "filter_stack add type l";
      ".m" = "console filter_stack add mime%space";
      ".n" = "console filter_stack add name%space";
      ".#" = "console filter_stack add hash%space";
      ".'" = "filter_stack add unique";
      ".|" = "filter_stack add or";
      ".&" = "filter_stack add and";
      ".!" = "filter_stack add not";
      ".r" = "filter_stack rotate";
      ".c" = "filter_stack clear";
      ".*" = "filter_stack decompose";
      ".p" = "filter_stack pop";
      ".." = "filter_stack show";
      # Bookmarks
      "`<any>"  = "enter_bookmark %any";
      "'<any>"  = "enter_bookmark %any";
      "m<any>"  = "set_bookmark %any";
      "um<any>" = "unset_bookmark %any";
      "m<bg>"   = "draw_bookmarks";

    };
    rifle = [
      # Don't work >:( FIXME
      # {
      #   condition = "ext STEP";
      #   command = "freecad \"$@\"";
      # }

      {
        condition = "ext pdf, has sioyek, X, flag f";
        command = "sioyek \"$@\"";
      }
      {
        condition = "ext x?html?, has firefox, X, flag f";
        command = "firefox -- \"$@\"";
      }
      {
        condition = "mime ^text,  label editor" ;
        command = "\${VISUAL:-$EDITOR} -- \"$@\"";
      }
      {
        condition = "mime ^text,  label pager";
        command = "$PAGER -- \"$@\"";
      }
      {
        condition = "!mime ^text, label editor, ext xml|json|csv|tex|py|pl|rb|rs|js|sh|php|dart";
        command = "\${VISUAL:-$EDITOR} -- \"$@\"";
      }
      {
        condition = "!mime ^text, label pager,  ext xml|json|csv|tex|py|pl|rb|rs|js|sh|php|dart";
        command = "$PAGER -- \"$@\"";
      }
      {
        condition = "ext py";
        command = "python -- \"$1\"";
      }
      {
        condition = "ext nu";
        command = "nu -- \"$1\"";
      }
      {
        condition = "ext sh";
        command = "sh -- \"$1\"";
      }
      {
        condition = "mime ^audio|ogg$, terminal, has mpv";
        command = "mpv -- \"$@\"";
      }
      {
        condition = "mime ^video, has mpv, X, flag f";
        command = "mpv -- \"$@\"";
      }
      {
        condition = "ext aup, has audacity, X, flag f";
        command = "audacity -- \"$@\"";
      }
      {
        condition = "mime ^video, terminal, !X, has mpv";
        command = "mpv -- \"$@\"";
      }
      {
        condition = "ext sc, has sc-im";
        command = "sc-im -- \"$@\"";
      }
      {
        condition = "ext pptx?|od[dfgpst]|docx?|sxc|xlsx?|xlt|xlw|gnm|gnumeric, has libreoffice, X, flag f";
        command = "libreoffice \"$@\"";
      }
      {
        condition = "mime ^image, has feh, X, flag f, !ext gif";
        command = "feh -- \"$@\"";
      }
      {
        condition = "ext kra, has krita, X, flag f";
        command = "krita -- \"$@\"";
      }
      {
        condition = "mime ^image/svg, has inkscape, X, flag f";
        command = "inkscape -- \"$@\"";
      }
      {
        condition = "ext ace|ar|arc|bz2?|cab|cpio|cpt|deb|dgc|dmg|gz,     has atool";
        command = "atool --list --each -- \"$@\" | $PAGER";
      }
      {
        condition = "ext iso|jar|msi|pkg|rar|shar|tar|tgz|xar|xpi|xz|zip, has atool";
        command = "atool --list --each -- \"$@\" | $PAGER";
      }
      {
        condition = "ext 7z|ace|ar|arc|bz2?|cab|cpio|cpt|deb|dgc|dmg|gz,  has atool";
        command = "atool --extract --each -- \"$@\"";
      }
      {
        condition = "ext iso|jar|msi|pkg|rar|shar|tar|tgz|xar|xpi|xz|zip, has atool";
        command = "atool --extract --each -- \"$@\"";
      }
      {
        condition = "mime ^ranger/x-terminal-emulator, has kitty";
        command = "kitty -- \"$@\"";
      }
      {
        condition = "label open, has xdg-open";
        command = "xdg-open \"$@\"";
      }
      {
        condition = "label open, has open";
        command = "open -- \"$@\"";
      }
      {
        condition = "!mime ^text, !ext xml|json|csv|tex|py|pl|rb|rs|js|sh|php|dart";
        command = "ask";
      }
      {
        condition = "label editor, !mime ^text, !ext xml|json|csv|tex|py|pl|rb|rs|js|sh|php|dart";
        command = "\${VISUAL:-$EDITOR} -- \"$@\"";
      }
      {
        condition = "label pager,  !mime ^text, !ext xml|json|csv|tex|py|pl|rb|rs|js|sh|php|dart";
        command = "$PAGER -- \"$@\"";
      }
      {
        condition = "mime application/x-executable =";
        command = "\"$1\"";
      }
    ];

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
      "linear_filter" = "1";
      "force_custom_line_algorithm" = "1";
      "status_bar_font_size" = "14";
      # "inverse_search_command" = "kitty -e \"nvim +%2 %1\"";

    };
  };
  # https://github.com/ahrm/sioyek/blob/main/pdf_viewer/prefs.config
  # https://github.com/ahrm/sioyek/blob/main/pdf_viewer/keys.config

  services.tldr-update.enable = true;


  # Don't work, cannot get info
  services.redshift.enable = true;
  services.redshift.provider = "geoclue2";

  services.easyeffects = {
    enable = true;
  };

  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        "phone" = { id = "F76YWQC-6F5ADDO-X6QO4XV-4AWXYKI-M47JE2Z-EMKKIES-7DUMMMC-GIEN3AJ"; };
      };
      folders = {
        "Obsidian" = {
          path = "/home/mlys/Obsidian";
          devices = [ "phone" ];
        };
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [ ".wallpaper.jpg" ];

      wallpaper = [
        ", .wallpaper.jpg"
      ];
    };
  };

  services.mako = {
    enable = true;
    font = config.default.main-font;
    defaultTimeout = 4000; 
    backgroundColor = "#${config.default.colors.background}";
    borderColor = "#${config.default.colors.border}";
  };

  programs.mangohud.enable = true;

  programs.nushell.enable = true;
  programs.nushell = {
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
    fuzzel           # program menu
    kitty            # terminal emulator
    firefox          # browser
    git              # GIT
    wofi             # needed for waybar config, may delete soon TODO
    brightnessctl    # brightness control
    mako             # notifications
    hyprpaper        # background image for hyprland
    telegram-desktop # telegram(messenger)

    sioyek           # nvim-esque pdf-reader
    tectonic         # LaTeX processing
    # waybar           # info bar for wayland and hyprland

    rustc            # Rust programming language
    clippy           # Rust linter
    cargo            # rust package manager
    obsidian         # note taking
    sc-im            # tui spreadsheets
    lazygit          # tui git 
    qbittorrent      # torrent client
    syncthing        # p2p file sync between devices
    inkscape         # vector graphics
    zoom-us          # zoom calls
    grim             # screen shots together with slurp
    slurp            # 
    steamcmd         # steam cli
    steam-tui        # Tui version of Steam
    fastfetch        # System fetch
    bacon            # Rust "jit" compilation tool
    mpv              # video player
    pyradio        # tui radio
    feh              # image viewer

    libreoffice-fresh  # office editors doc,xlsx, etc
    discord          # voice and text-chat app
    # fzf              # cli fuzzy finder
    smassh           # tui typing training
    gpg-tui          # tui gpg
    kega-fusion      # SEGA emulator
    btop             # tui system monitor
    timer	           # tui timer
    wf-recorder      # screen capture
    pavucontrol      # pulse audio control for waybar
    networkmanagerapplet # connections control for waybar

    wasistlos # whatsapp client

    sc-controller

    atool              # needed for archive zipping un zipping in ranger 
    highlight          # ranger file preview highlight
    orca-c             # esoteric programming sequencer
    cava               # audio visualizer
    libremines         # minesweeper
    lutris             # unified game launcher proton/wine wrapper
    aseprite           # pixel img/animation drawing software
    pipes-rs           # cli pipes simulation
    wl-color-picker    # color picker
    freecad-wayland    # CAD software
    orca-slicer        # 3D printing slicer
    xournalpp          # More advanced whiteboard
    gsettings-desktop-schemas       # Needed for Sioyek TODO still broken
    tldr               # Offline command Manual, substitute for `man` command
    osu-lazer-bin
    wev
    hyprpicker         # Another Color picker need further comparison with wl-color-picker
    slack              # Business communication (Discord for KSE)
    slack-term         # TUI Slack
    gcalcli            # TUI Google Calendar
    viber




  ] ++ (if config.default.isPC then [
      # PC Soft
      prismlauncher
      protonup
      wine-wayland
      winetricks
    ] else []);

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];
    settings = {
      misc.enable_anr_dialog = false;
      decoration = {
        rounding = "0";
        active_opacity = "1.0";
        inactive_opacity = "1.0";
        blur = {
          enabled = true;
          size = "3";
          passes = "1";
          vibrancy = "0.1696";
        };
      };
      exec-once = [
        "waybar"
        "hyprpaper"
        "steam -silent"
        "slack -u"
        "easyeffects --gapplication-service"
        "discord --start-minimized"
        "telegram-desktop -startintray"
        "udiskie"
        "hyprctl setcursor ${config.default.cursor.name} 24"
        "kitty -e aerc"
        # "whatsapp-for-linux"
      ];
      env = [
        "CLUTTER_BACKEND,wayland"
        "GDK_BACKEND,wayland,x11"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,wayland"
        "GSETTINGS_SCHEMA_DIR, ${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
        "LD_LIBRARY_PATH=\$\{LD_LIBRARY_PATH\}:${ pkgs.lib.makeLibraryPath [ pkgs.vulkan-loader ] }"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "MOZ_ENABLE_WAYLAND,1"
        "GDK_SCALE,auto"
        # "GTK_USE_PORTAL=1"
      ];
      general = {
        gaps_in = "2";
        gaps_out = "5";
        border_size = "1";
        "col.active_border" = "rgba(${config.default.colors.border}ff)";
        "col.inactive_border" = "rgba(${config.default.colors.background}ff)";
        resize_on_border = false; 
        allow_tearing = false;
        layout = "dwindle";
      };
      animations.enabled = false;
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_status = "master";
      };
      misc = { 
        force_default_wallpaper = "-1"; 
        disable_hyprland_logo = false; 
      };
      input = {
        kb_layout = "us,ua,ru"; #,ru
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:alt_shift_toggle"; 
        kb_rules = "";
        follow_mouse = "1";
        sensitivity = "0";
        touchpad = {
          natural_scroll = true;
          tap-to-click = false;
        };
        # force_no_accel = true;
        repeat_delay = 300;

      };
      gestures = {
        workspace_swipe = false;
      };
      device = {
        name = "e-signal-hator-pulsar";
        sensitivity = "-0.5";
      };
      monitor = if config.default.isPC then ",1920x1080@75,auto,auto" else ",,auto,auto";

      xwayland.force_zero_scaling = true;

      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "fuzzel";

      bind = [
        # screenshot of a region
        '', Print, exec, grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | mako "Screenshot of the region taken" -t 1000''
        # screenshot of the whole screen
        ''SHIFT, Print, exec, grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | mako "Screenshot of whole screen taken" -t 1000''
        "$mainMod, Q, exec, $terminal --class=terminal"
        # "$mainMod, O, exec, obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland"
        "$mainMod, O, exec, obsidian"
        "$mainMod, C, killactive,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, R, exec, $terminal -e ranger"
        "$mainMod, N, exec, $terminal -e nvim"
        "$mainMod, G, exec, kega-fusion"
        "$mainMod, M, exec, $menu"
        "$mainMod, F, exec, firefox"
        "$mainMod, T, exec, telegram-desktop"
        "$mainMod, S, exec, $terminal -o \"font_size 8.0\" -e sc-im"
        "$mainMod, I, exec, inkscape"
        "$mainMod, P, exec, $terminal --class=timer -e timer 25m"
        "$mainMod CTRL, l, resizeactive, 15 0"
        "$mainMod CTRL, h, resizeactive, -15 0"
        "$mainMod CTRL, k, resizeactive, 0 -15"
        "$mainMod CTRL, j, resizeactive, 0 15"
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        "$mainMod SHIFT, T, togglefloating,"
        "$mainMod SHIFT, F, fullscreen,"
        "$mainMod SHIFT, C, centerwindow,"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      windowrulev2 = [
        "float,        initialClass:(mpv)"

        "float,        class:(org.telegram.desktop)"

        "tile,         class:Aseprite"

        "float,        class:(timer)"
        "move 950 40,  class:(timer)"
        "size 320 50,  class:(timer)"

        "float,        title:(pdflatex)"
        "float,        title:(Console window)"
        "float,        title:(Library)"
        "float,        title:(Save As)"
        "center,       title:(Save As)"
        "size 800 400, title:(Save As)"

        "float,        title:(Steam Settings)"
        "float,        title:(Friends List)"

        "float,        title:(Save File)"
        "center,       title:(Save File)"
        "size 800 400, title:(Save File)"

        "float,                   class:(btop)"
        "move 2% 5%,        class:(btop)"
        "size <30% <50%, class:(terminal)"

        "float,        class:(terminal)"
        "center,       class:(terminal)"
        "size <30% <30%, class:(terminal)"

        "float,        title:(Picture-in-Picture)"
        "center,       title:(Picture-in-Picture)"

        "fullscreen,   title:(Inkscape)"

        "fullscreen,   class:(Fusion)"
        # wifi connection connection editoreditor
        "float,        class:(nm-connection-editor)"
        "move 920 40,  class:(nm-connection-editor)"
        "size 350 250, class:(nm-connection-editor)"
        # pulseaudio audio editor
        "float,        class:(org.pulseaudio.pavucontrol)"
        "move 10 40,   class:(org.pulseaudio.pavucontrol)"
        "size 350 250, class:(org.pulseaudio.pavucontrol)"
      ];
    };
  };


  # Declarative file creation
  home.file = {
    # "sega/Contra_Hard_Corps.gen" = {
    #   source = pkgs.fetchurl {
    #     url = "https://www.emu-land.net/en/consoles/genesis/roms?act=getmfl&id=174&fid=4759";
    #     sha256 = "sha256-Xz2Fod61AdBaRzurWm1uxfsOwhp430XOl+VHCneSS2Q";
    #     # nativeBuildInputs = [ unzip ];
    #     downloadToTemp = true;
    #     postFetch = ''
    #       unzip $downloadedFile
    #       touch "kappa.txt"
    #     '';
    #   };
    # };
    ".wallpaper2.jpg" = {
      source = pkgs.fetchurl {
        url = "https://images.unsplash.com/photo-1522124624696-7ea32eb9592c?q=80&w=2669&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
        sha256 = "sha256-7bwrUC19wzbDs0UZWkc3l20DvoWuL6/sbnzgsSkuRjc";
      };
    };
    "foo/bar.tex".enable = true;
    "foo/bar.tex".text = ''
      \document{article}
    '';
    ".config/pyradio/config".enable = true;
    ".config/pyradio/config".text = ''
      theme = catppuccin-mocha
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
