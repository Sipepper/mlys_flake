{ config, pkgs, nixpkgs-stable, inputs, lib, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./default.nix
  ];

  programs = {
    fzf = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "Sipepper";
      userEmail = "valera1gribnik@gmail.com";
    };

    # TUI File manager
    nnn = {
      enable = true;
      package = pkgs.nnn.override { withNerdIcons = true;};
      extraPackages = with pkgs; [
        file
      ];
      plugins = {
        src = (pkgs.fetchFromGitHub {
          owner = "jarun";
          repo = "nnn";
          rev = "4.0";
          sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
        }) + "/plugins";
        mappings = {
          v = "preview-tui";
        };
        
      };
    };
    nixvim = {
      enable = true;
      defaultEditor = true;
      vimdiffAlias = true;
      # performance.combinePlugins.enable = true;
      colorschemes.nightfox.enable = true;
      # extraConfigLua = ''
      #   require("nnn").setup({
      #     replace_netrw = "picker",
      #     -- windownav = "<C-l>"
      #     picker = {
      #       cmd = "nnn -P v";
      #     };
      #   });
      # '';
      extraPlugins = with pkgs; [
        vimPlugins.nnn-vim
      ];


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
          action = "<cmd>NnnPicker<cr>";
          key = "<leader>f";
          options.desc = "NNN Pick";
        }
        {
          action = "<cmd>NnnExplorer<cr>";
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
            ts_ls.enable = true;
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
