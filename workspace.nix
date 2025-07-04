{ config, pkgs, nixpkgs-stable, inputs, lib, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./default.nix
  ];

  programs = {
    mergiraf.enable = true;

    fzf = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "Sipepper";
      userEmail = "valera1gribnik@gmail.com";
      difftastic = {
        enable = true;
        color = "always";
        enableAsDifftool = true;
      };
      extraConfig = {
        init.defaultBranch = "main";
        merge.tool = "mergiraf";
      };
    };

    # TUI File manager
    yazi = {
      enable = true;
      # keymap = {
      #   TODO 
      #     https://github.com/sxyazi/yazi/blob/shipped/yazi-config/preset/keymap-default.toml
      #   manager.keymap = [
      #     { run = "open"; on = [ "l" ]; }
      #   ];
      # };
      settings = {
        # preview.image_delay = 0;

        plugin.prepend_previewers = [
          { mime = "application/*zip";            run = "ouch"; }
          { mime = "application/x-tar";           run = "ouch"; }
          { mime = "application/x-bzip2";         run = "ouch"; }
          { mime = "application/x-7z-compressed"; run = "ouch"; }
          { mime = "application/x-rar";           run = "ouch"; }
          { mime = "application/x-xz";            run = "ouch"; }
          { mime = "application/xz";              run = "ouch"; }
        ];
      };
      plugins = {
        lazygit = pkgs.yaziPlugins.lazygit;
        smart-enter = pkgs.yaziPlugins.smart-enter;
        rsync = pkgs.yaziPlugins.rsync;
        full-border = pkgs.yaziPlugins.full-border;
        relative-motions = pkgs.yaziPlugins.relative-motions;
        ouch = pkgs.yaziPlugins.ouch;
        diff = pkgs.yaziPlugins.diff;
        # yatline = pkgs.yaziPlugins.yatline;
        custom-shell = pkgs.fetchFromGitHub {
          owner = "AnirudhG07";
          repo = "custom-shell.yazi";
          # repo = "https://github.com/AnirudhG07/custom-shell.yazi";
          rev = "6b4550a1b18afbb7ef328ebf54d81de24101288e";
          sha256 = "1msaj7h2lfbzi6a06jrcvhaq57qqnsg157nj5pmr1zh9rr8dpqkm";
        };
      };
      initLua = ./assets/yazi_init.lua;
      shellWrapperName = "y";

    };

    nixvim = {
      enable = true;
      defaultEditor = true;
      vimdiffAlias = true;
      performance.combinePlugins.enable = true;
      colorschemes.nightfox.enable = true;
      extraPlugins = with pkgs; [ ];

      globals = {
        mapleader = " ";
        _ts_force_sync_parsing = true;
      };


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
        { action = "<C-w>l"; key = "<C-l>"; options.desc = "sd1"; }
        { action = "<C-w>h"; key = "<C-h>"; options.desc = "sd4"; }
        { action = "<C-w>j"; key = "<C-j>"; options.desc = "sd3"; }
        { action = "<C-w>k"; key = "<C-k>"; options.desc = "sd2"; }
        { action = "<cmd>noh<CR>"; key = "<Esc><Esc>"; options.desc = "which_key_ignore"; }
        { action = "<cmd>BufferLineCloseOthers<CR>"; key = "<leader>bo"; options.desc = "Close other buffers"; }
        { action = "<cmd>bdelete<CR>"; key = "<leader>bd"; options.desc = "Close buffer"; }
        { action = "<cmd>bnext<CR>"; key = "<S-l>"; options.desc = "Move to right tab"; }
        { action = "<cmd>bprev<CR>"; key = "<S-h>"; options.desc = "Move to left tab"; }
        { action = "<cmd>Telescope live_grep<CR>"; key = "<leader>g"; options.desc = "Live Grep"; }
        { action = "<cmd>LazyGitCurrentFile<CR>"; key = "<leader>lg"; options.desc = "LazyGit"; }
        { action = "<cmd>Yazi<cr>"; key = "<leader>f"; options.desc = "Yazi"; }
        { action = "<cmd>wq<CR>"; key = "<leader>qq"; options.desc = "Save and quit"; }
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
        yazi = {
          enable = true;
          settings = {
            enable_mouse_support = true;
            floating_window_scaling_factor = 0.8;
            log_level = "debug";
            yazi_floating_window_border = "single";
            # yazi_floating_window_winblend = 50;
          };
        };

        nix.enable = true;
        web-devicons.enable = true;
        telescope.enable = true;
        bacon.enable = true;

        bufferline = {
          enable = true;
          settings = {
            options.always_show_bufferline = false;
            # options.custom_filter = ''
            #   function(buf_number)
            #     if not not vim.api.nvim_buf_get_name(buf_number):find(vim.fn.getcwd(), 0, true) then
            #       return true
            #     end
            #   end,
            # '';
          };
        };
        nvim-autopairs = {
          enable = true;
          # luaConfig.post = ''
          #   Rule("$", "$", "tex")
          #     :with_move(function(opts)
          #     return opts.next_char == opts.char
          #     end)
          # '';
          settings = {
            check_ts = true;
            disable_filetype = [
              "TelescopePrompt"
            ];
            fast_wrap = {
              end_key = "$";
              map = "<M-e>";
              chars = [
                "$"
                "{"
                "["
                "("
                "\""
                "'"
              ];
            };
          };
        };
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
          # git.paging.pager = "difftastic";
          git.paging.pager = "mergiraf";
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
        fzf-lua.enable = true;
        noice.enable = false;
        notify.enable = true;
        lualine.enable = true; 
        luasnip = {
          enable = true;
          fromLua = [
            { paths = ./assets/snippets; }
          ];
        };

        dashboard.enable = true;
        dashboard.settings = {
          change_to_vcs_root = true;
          config = {
            footer = [
              "░ᚠᚢᛚᛗ᛫ᚪᛠᚣᛟᚪ░"
            ];
            header = [
              "⠀⠀⣀⣤⠤⠶⠶⠶⠶⠶⠶⢶⠶⠶⠦⣤⣄⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣤⡤⣤⠶⠴⠶⠶⠶⣶⠶⠶⢤⣤⣀⡀ "
              "⣴⡏⠡⢒⡸⠋⠀⠐⣾⠉⠉⠭⢄⣠⢤⡷⠷⢾⣛⣿⠷⣶⣤⣄⡀⠀⠀⠐⢿⣟⢲⡁⠐⣾⠛⠃⠀⠀⢀⣠⡤⠶⠒⣛⣩⠝⢋⣠⣰⣂⣤⠴⠏⠉⠓⢺⡿⢁⣴⣮⢽⡟ "
              "⠙⠶⣞⣥⡴⠚⣩⣦⠨⣷⠋⠠⠤⠶⢲⡺⠢⣤⡼⠿⠛⠛⣻⣿⣿⠿⢶⣤⣿⣯⡾⠗⠾⣇⣙⣤⡶⢿⣯⡕⢖⣺⠋⣭⣤⣤⢤⡶⠖⠮⢷⡄⠛⠂⣠⣽⡟⢷⣬⡿⠋⠁ "
              "⠀⠀⠀⠈⠒⢿⣁⡴⠟⣊⣇⠠⣴⠞⣉⣤⣷⣤⠶⠿⢛⢛⠩⠌⠚⢁⣴⣿⠏⠀⣴⠀⢀⣦⠻⠻⣑⠢⢕⡋⢿⡿⣿⣷⢮⣤⣷⣬⣿⠷⠈⢁⣤⣾⡿⣽⡮⠋⠀⠀⠀⠀ "
              "⠀⠀⠀⠀⠀⠈⠛⠷⣾⣋⣤⡾⠛⣁⡡⢤⡾⢤⡖⠋⠉⠀⠀⠀⠀⠀⢰⣿⡷⠺⠛⠐⡿⠃⠦⠤⠈⠉⠢⠄⠈⠁⠙⢿⣮⣿⢤⣶⣁⣀⣛⣿⣷⠼⠚⠁⠀⠀⠀⠀⠀⠀ "
              "⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠙⠇⠀⣩⡥⠞⢗⣼⣧⠀⠀⠀⠀⠀⠀⠀⢈⣿⡇⢄⡤⠤⣧⠄⢀⡀⠀⠀⠀⠀⠀⠀⠀⢘⣿⡟⠺⣯⣽⡉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
              "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠇⣊⣭⢿⡛⠁⡅⠀⠀⠀⠀⠀⠀⠈⢻⡇⢘⣡⣀⡀⣏⠀⠃⠀⠀⠀⠀⠀⠀⠀⣸⡏⠈⢦⣶⣿⡟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
              "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣥⡔⣫⠔⡀⡰⠀⠀⠀⠀⠀⠀⠀⢺⡇⠈⢰⠀⢹⠇⠀⡘⡄⠀⠀⠀⠀⠀⢠⣿⣄⢠⣾⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
              "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠷⠺⠘⠛⠛⠓⢂⠀⠀⠀⠀⠸⣧⠀⢺⠀⠊⠀⠰⠇⠘⢄⡀⠀⠰⠶⡛⠓⠟⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
              "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣆⠛⠒⠁⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
              "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
              "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
              "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
            ];
            packages.enable = false;
            mru.limit = 6;
            project = {
              enable = true;
              limit = 4;
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
            ts_ls.enable = true;
            rust_analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
            };
            texlab.enable = true;
            nixd.enable = true;
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

        cmp-vimtex.enable = true;

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

  };
}
