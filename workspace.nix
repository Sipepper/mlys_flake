{ pkgs, lib, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./default.nix
  ];

  programs = {
    firefox = {
      enable = true;

    };


    obsidian = {
      enable = false;
      vaults = {
        "mind-garden" = {
          enable = true;
          target = "/Obsidian";
          settings = {

            app = {
              livePreview = false;
              vimMode = true;
              attachmentFolderPath = "Attachments";
              propertiesInDocument = "visible";

              pdfExportSettings = {
                includeName = true;
                pageSize = "Letter";
                landscape = false;
                margin = 0;
                downscalePercent = 100;
              };

              alwaysUpdateLinks = true;
              promptDelete = false;
              trashOption = "none";
              showLineNumber = true;
            };

            appearance = {
              nativeMenus = false;
              theme = "obsidian";
              interfaceFontFamily = "Iosevka Custom,Iosevka Nerd Font,Hurmit Nerd Font";
              textFontFamily = "Iosevka Custom,Iosevka Nerd Font,Hurmit Nerd Font Propo";
              monospaceFontFamily = "Iosevka Nerd Font Mono,Hurmit Nerd Font Mono";
              showRibbon = true;
              baseFontSize = 16;
              cssTheme = "Nightfox";
            };


            # TODO Not working here (have no clue how to resolve yet)
            communityPlugins = [
              {"quick-latex".enable = true;}
              {"obsidian-admonition".enable = true;}
              {"templater-obsidian".enable = true;}
              {"dataview".enable = true;}
              {"tag-wrangler".enable = true;}
              {"obsidian-vault-statistics-plugin".enable = true;}
              {"obsidian-excalidraw-plugin".enable = true;}
              {"graph-analysis".enable = true;}
              {"obsidian-dangling-links".enable = true;}
              {"calendar".enable = true;}
              {"contribution-graph".enable = true;}
              {"obsidian-spaced-repetition".enable = true;}
              {"obsidian-kanban".enable = true;}
              {"homepage".enable = true;}
              {"oz-clear-unused-images".enable = true;}
              {"performosu".enable = true;}
              {"obsidian42-strange-new-worlds".enable = true;}
              {"cut-the-fluff".enable = true;}
              {"notes-explorer".enable = true;}
              {"obsidian-relative-line-numbers".enable = true;}
              {"obsidian-collapse-all-plugin".enable = true;}
              {"code-emitter".enable = true;}
              {"code-styler".enable = true;}
              {"obsidian-tracker".enable = true;}
            ];

            corePlugins = [
              {name = "file-explorer"; enable = true;}
              {name = "global-search"; enable = true;}
              {name = "switcher";enable = true;}
              {name = "graph"; enable = true;}
              {name = "backlink"; enable = true;}
              {name = "outgoing-link"; enable = true;}
              {name = "tag-pane"; enable = true;}
              {name = "page-preview"; enable = true;}
              {name = "daily-notes"; enable = true;}
              {name = "templates"; enable = true;}
              {name = "note-composer"; enable = true;}
              {name = "command-palette"; enable = true;}
              {name = "slash-command"; enable = false;}
              {name = "editor-status"; enable = false;}
              {name = "starred"; enable = true;}
              {name = "markdown-importer"; enable = false;}
              {name = "zk-prefixer"; enable = false;}
              {name = "random-note"; enable = true;}
              {name = "outline"; enable = true;}
              {name = "word-count"; enable = true;}
              {name = "slides"; enable = true;}
              {name = "audio-recorder"; enable = false;}
              {name = "workspaces"; enable = true;}
              {name = "file-recovery"; enable = true;}
              {name = "publish"; enable = false;}
              {name = "sync"; enable = false;}
              {name = "canvas"; enable = true;}
              {name = "bookmarks"; enable = true;}
              {name = "properties"; enable = true;}
            ];
          };
        };
      };
    };



    mergiraf.enable = true;

    fzf = {
      enable = true;
    };

    git = {
      enable = true;
      settings = {
        user = {
          name = "Sipepper";
          email = "valera1gribnik@gmail.com";
        };
        init.defaultBranch = "main";
        merge = {
          tool = "mergiraf";
          driver = "mergiraf merge --git %O %A %B -s %S -x %X -y %Y -p %P -l %L";
        };
        credential.helper = "${pkgs.gh}";
      };
    };

    difftastic = {
      enable = true;
      git = {
        enable = true;
        diffToolMode = true;
      };
      options = {
        color = "always";
      };
    };

    # TUI File manager
    yazi = {
      enable = true;
      keymap = {
        mgr.keymap = [
          { on = "<Esc>"; run = "escape";             desc = "Exit visual mode, clear selection, or cancel search"; }
          { on = "q";     run = "quit";               desc = "Quit the process"; }
          { on = "Q";     run = "quit --no-cwd-file"; desc = "Quit without outputting cwd-file"; }
          { on = "<C-c>"; run = "close";              desc = "Close the current tab; or quit if it's last"; }
          { on = "<C-z>"; run = "suspend";            desc = "Suspend the process"; }
          # Hopping
          { on = "k"; run = "arrow prev"; desc = "Previous file"; }
          { on = "j"; run = "arrow next"; desc = "Next file"; }
          { on = "<C-d>"; run = "plugin diff";   desc = "Diff the selected with the hovered file"; }
          { on = [ "g" "g" ]; run = "arrow top"; desc = "Go to top"; }
          { on = "G";          run = "arrow bot"; desc = "Go to bottom"; }
          # Navigation
          { on = "h"; run = "leave"; desc = "Back to the parent directory"; }
          { on = "l"; run = "plugin smart-enter"; desc = "Enter the child directory"; }
          { on = "H"; run = "back";    desc = "Back to previous directory"; }
          { on = "L"; run = "forward"; desc = "Forward to next directory"; }
          # Toggle
          { on = "<Space>"; run = [ "toggle" "arrow next" ]; desc = "Toggle the current selection state"; }
          { on = "<C-a>";   run = "toggle_all --state=on";    desc = "Select all files"; }
          { on = "<C-r>";   run = "toggle_all";               desc = "Invert selection of all files"; }
          # Visual mode
          { on = "v"; run = "visual_mode";         desc = "Enter visual mode (selection mode)"; }
          { on = "V"; run = "visual_mode --unset"; desc = "Enter visual mode (unset mode)"; }
          # Seeking
          { on = "K"; run = "seek -5"; desc = "Seek up 5 units in the preview"; }
          { on = "J"; run = "seek 5";  desc = "Seek down 5 units in the preview"; }
          # Spotting
          { on = "<Tab>"; run = "spot"; desc = "Spot hovered file"; }
          # Operation
          { on = "o";         run = "open --interactive";          desc = "Open selected files interactively"; }
          { on = "y";         run = "yank";                        desc = "Yank selected files (copy)"; }
          { on = "x";         run = "yank --cut";                  desc = "Yank selected files (cut)"; }
          { on = "p";         run = "paste";                       desc = "Paste yanked files"; }
          { on = "P";         run = "paste --force";               desc = "Paste yanked files (overwrite if the destination exists)"; }
          { on = "-";         run = "link";                        desc = "Symlink the absolute path of yanked files"; }
          { on = "_";         run = "link --relative";             desc = "Symlink the relative path of yanked files"; }
          { on = "<C-->";     run = "hardlink";                    desc = "Hardlink yanked files"; }
          { on = "Y";         run = "unyank";                      desc = "Cancel the yank status"; }
          { on = "X";         run = "unyank";                      desc = "Cancel the yank status"; }
          { on = "d";         run = "remove --permanently";                      desc = "Delete selected files"; }
          # { on = "D";         run = "remove --permanently";        desc = "Permanently delete selected files"; }
          { on = "a";         run = "create";                      desc = "Create a file (ends with / for directories)"; }
          { on = "r";         run = "rename --cursor=before_ext";  desc = "Rename selected file(s)"; }
          { on = ":";         run = "shell --block --interactive"; desc = "Run a shell command (block until finishes)"; }
          { on = ".";         run = "hidden toggle";               desc = "Toggle the visibility of hidden files"; }
          { on = "s";         run = "search --via=fd";             desc = "Search files by name via fd"; }
          { on = "S";         run = "search --via=rg";             desc = "Search files by content via ripgrep"; }
          { on = "<C-s>";     run = "escape --search";             desc = "Cancel the ongoing search"; }
          { on = "z";         run = "plugin fzf";                  desc = "Jump to a file/directory via fzf"; }
          { on = "Z";         run = "plugin zoxide";               desc = "Jump to a directory via zoxide"; }
          # Linemode
          { on = [ "m"  "s" ]; run = "linemode size";        desc = "Linemode: size"; }
          { on = [ "m"  "p" ]; run = "linemode permissions"; desc = "Linemode: permissions"; }
          { on = [ "m"  "b" ]; run = "linemode btime";       desc = "Linemode: btime"; }
          { on = [ "m"  "m" ]; run = "linemode mtime";       desc = "Linemode: mtime"; }
          { on = [ "m"  "o" ]; run = "linemode owner";       desc = "Linemode: owner"; }
          { on = [ "m"  "n" ]; run = "linemode none";        desc = "Linemode: none"; }
          # Copy
          { on = [ "c"  "c" ]; run = "copy path";             desc = "Copy the file path"; }
          { on = [ "c"  "d" ]; run = "copy dirname";          desc = "Copy the directory path"; }
          { on = [ "c"  "f" ]; run = "copy filename";         desc = "Copy the filename"; }
          { on = [ "c"  "n" ]; run = "copy name_without_ext"; desc = "Copy the filename without extension"; }
          # Filter
          { on = "f"; run = "filter --smart"; desc = "Filter files"; }
          # Find
          { on = "/"; run = "find --smart";            desc = "Find next file"; }
          { on = "?"; run = "find --previous --smart"; desc = "Find previous file"; }
          { on = "n"; run = "find_arrow";              desc = "Next found"; }
          { on = "N"; run = "find_arrow --previous";   desc = "Previous found"; }
          # Sorting
          { on = [ ","  "m" ]; run = [ "sort mtime --reverse=no" "linemode mtime" ]; desc = "Sort by modified time"; }
          { on = [ ","  "M" ]; run = [ "sort mtime --reverse" "linemode mtime" ];    desc = "Sort by modified time (reverse)"; }
          { on = [ ","  "b" ]; run = [ "sort btime --reverse=no" "linemode btime" ]; desc = "Sort by birth time"; }
          { on = [ ","  "B" ]; run = [ "sort btime --reverse" "linemode btime" ];    desc = "Sort by birth time (reverse)"; }
          { on = [ ","  "e" ]; run = "sort extension --reverse=no";                   desc = "Sort by extension"; }
          { on = [ ","  "E" ]; run = "sort extension --reverse";                      desc = "Sort by extension (reverse)"; }
          { on = [ ","  "a" ]; run = "sort alphabetical --reverse=no";                desc = "Sort alphabetically"; }
          { on = [ ","  "A" ]; run = "sort alphabetical --reverse";                   desc = "Sort alphabetically (reverse)"; }
          { on = [ ","  "n" ]; run = "sort natural --reverse=no";                     desc = "Sort naturally"; }
          { on = [ ","  "N" ]; run = "sort natural --reverse";                        desc = "Sort naturally (reverse)"; }
          { on = [ ","  "s" ]; run = [ "sort size --reverse=no" "linemode size" ];   desc = "Sort by size"; }
          { on = [ ","  "S" ]; run = [ "sort size --reverse" "linemode size" ];      desc = "Sort by size (reverse)"; }
          { on = [ ","  "r" ]; run = "sort random --reverse=no";                      desc = "Sort randomly"; }
          # Goto
          { on = [ "g"  "h" ];       run = "cd ~";                          desc = "Go home"; }
          { on = [ "g"  "c" ];       run = "cd ~/.config";                  desc = "Go ~/.config"; }
          { on = [ "g"  "d" ];       run = "cd ~/Downloads";                desc = "Go ~/Downloads"; }
          { on = [ "g"  "<Space>" ]; run = "cd --interactive";              desc = "Jump interactively"; }
          { on = [ "g"  "f" ];       run = "follow";                        desc = "Follow hovered symlink"; }
          { on = [ "g"  "m" ];       run = "cd /run/media/mlys/";           desc = "Open removable media"; }
          { on = [ "g"  "o" ];       run = "cd ~/Obsidian";                 desc = "Open Obsidian folder"; }
          { on = [ "g"  "r" ];       run = "cd ~/Rust";                     desc = "Open Rust folder"; }
          { on = [ "g"  "l" ];       run = "cd ~/LaTeX";                    desc = "Open LaTeX folder"; }
          { on = [ "g"  "p" ];       run = "cd ~/Git";                      desc = "Open Git folder"; }
          { on = [ "g"  "b" ];       run = "cd ~/Obsidian/Books";           desc = "Open the library"; }
          # Tabs
          { on = "t"; run = "tab_create --current"; desc = "Create a new tab with CWD"; }
          { on = "<A-1>"; run = "tab_switch 0"; desc = "Switch to first tab"; }
          { on = "<A-2>"; run = "tab_switch 1"; desc = "Switch to second tab"; }
          { on = "<A-3>"; run = "tab_switch 2"; desc = "Switch to third tab"; }
          { on = "<A-4>"; run = "tab_switch 3"; desc = "Switch to fourth tab"; }
          { on = "<A-5>"; run = "tab_switch 4"; desc = "Switch to fifth tab"; }
          { on = "<A-6>"; run = "tab_switch 5"; desc = "Switch to sixth tab"; }
          { on = "<A-7>"; run = "tab_switch 6"; desc = "Switch to seventh tab"; }
          { on = "<A-8>"; run = "tab_switch 7"; desc = "Switch to eighth tab"; }
          { on = "<A-9>"; run = "tab_switch 8"; desc = "Switch to ninth tab"; }
          { on = "["; run = "tab_switch -1 --relative"; desc = "Switch to previous tab"; }
          { on = "]"; run = "tab_switch 1 --relative";  desc = "Switch to next tab"; }
          { on = "{"; run = "tab_swap -1"; desc = "Swap current tab with previous tab"; }
          { on = "}"; run = "tab_swap 1";  desc = "Swap current tab with next tab"; }
          # Tasks
          { on = "w"; run = "tasks:show"; desc = "Show task manager"; }
          # Help
          { on = "<F1>"; run = "help"; desc = "Open help"; }
        ];

        mgr.prepend_keymap = [
          { on = "1"; run = "plugin relative-motions 1"; desc = "Move in relative steps"; }
          { on = "2"; run = "plugin relative-motions 2"; desc = "Move in relative steps"; }
          { on = "3"; run = "plugin relative-motions 3"; desc = "Move in relative steps"; }
          { on = "4"; run = "plugin relative-motions 4"; desc = "Move in relative steps"; }
          { on = "5"; run = "plugin relative-motions 5"; desc = "Move in relative steps"; }
          { on = "6"; run = "plugin relative-motions 6"; desc = "Move in relative steps"; }
          { on = "7"; run = "plugin relative-motions 7"; desc = "Move in relative steps"; }
          { on = "8"; run = "plugin relative-motions 8"; desc = "Move in relative steps"; }
          { on = "9"; run = "plugin relative-motions 9"; desc = "Move in relative steps"; }
          { on = "y"; run = [ "shell -- for path in \"$@\"; do echo \"file://$path\"; done | wl-copy -t text/uri-list" "yank" ]; desc = "Smart copy"; }
          { on = [ ";" ]; run = "plugin custom-shell -- auto --interactive";  desc = "custom-shell as default"; }
          { on = "C"; run = "plugin ouch"; desc = "Compress with ouch"; }
          { on = "!"; run = "shell '$SHELL' --block"; desc = "Open $SHELL here"; }
        ];

        tasks.keymap = [
          { on = "w";     run = "close"; desc = "Close task manager"; }
          { on = "k"; run = "arrow prev"; desc = "Previous task"; }
          { on = "j"; run = "arrow next"; desc = "Next task"; }
          { on = "<Up>";   run = "arrow prev"; desc = "Previous task"; }
          { on = "<Down>"; run = "arrow next"; desc = "Next task"; }
          { on = "<Enter>"; run = "inspect"; desc = "Inspect the task"; }
          { on = "x";       run = "cancel";  desc = "Cancel the task"; }
          # Help
          { on = "<F1>"; run = "help"; desc = "Open help";}
        ];
        spot.keymap = [
          { on = "<Esc>"; run = "close"; desc = "Close the spot"; }
          { on = "<C-[>"; run = "close"; desc = "Close the spot"; }
          { on = "<C-c>"; run = "close"; desc = "Close the spot"; }
          { on = "<Tab>"; run = "close"; desc = "Close the spot"; }
          { on = "k"; run = "arrow prev"; desc = "Previous line"; }
          { on = "j"; run = "arrow next"; desc = "Next line"; }
          { on = "h"; run = "swipe prev"; desc = "Swipe to previous file"; }
          { on = "l"; run = "swipe next"; desc = "Swipe to next file"; }
          { on = "<Up>";    run = "arrow prev"; desc = "Previous line"; }
          { on = "<Down>";  run = "arrow next"; desc = "Next line"; }
          { on = "<Left>";  run = "swipe prev"; desc = "Swipe to previous file"; }
          { on = "<Right>"; run = "swipe next"; desc = "Swipe to next file"; }
          # Copy
          { on = [ "c" "c" ]; run = "copy cell"; desc = "Copy selected cell"; }
          # Help
          { on = "<F1>"; run = "help"; desc = "Open help"; }
        ];
        pick.keymap = [
          { on = "<Esc>";   run = "close";          desc = "Cancel pick"; }
          { on = "<C-[>";   run = "close";          desc = "Cancel pick"; }
          { on = "<C-c>";   run = "close";          desc = "Cancel pick"; }
          { on = "<Enter>"; run = "close --submit"; desc = "Submit the pick"; }
          { on = "k"; run = "arrow prev"; desc = "Previous option"; }
          { on = "j"; run = "arrow next"; desc = "Next option"; }
          { on = "<Up>";   run = "arrow prev"; desc = "Previous option"; }
          { on = "<Down>"; run = "arrow next"; desc = "Next option"; }
          # Help
          { on = "~";    run = "help"; desc = "Open help"; }
          { on = "<F1>"; run = "help"; desc = "Open help"; }
        ];
        input.keymap = [
          { on = "<C-c>";   run = "close";          desc = "Cancel input"; }
          { on = "<Enter>"; run = "close --submit"; desc = "Submit input"; }
          { on = "<Esc>";   run = "escape";         desc = "Back to normal mode, or cancel input"; }
          { on = "<C-[>";   run = "escape";         desc = "Back to normal mode, or cancel input"; }
          # Mode
          { on = "i"; run = "insert";                          desc = "Enter insert mode"; }
          { on = "I"; run = [ "move first-char" "insert" ];   desc = "Move to the BOL, and enter insert mode"; }
          { on = "a"; run = "insert --append";                 desc = "Enter append mode"; }
          { on = "A"; run = [ "move eol" "insert --append" ]; desc = "Move to the EOL, and enter append mode"; }
          { on = "v"; run = "visual";                          desc = "Enter visual mode"; }
          { on = "r"; run = "replace";                         desc = "Replace a single character"; }
          # Selection
          { on = "V";     run = [ "move bol" "visual" "move eol" ]; desc = "Select from BOL to EOL"; }
          { on = "<C-A>"; run = [ "move eol" "visual" "move bol" ]; desc = "Select from EOL to BOL"; }
          { on = "<C-E>"; run = [ "move bol" "visual" "move eol" ]; desc = "Select from BOL to EOL"; }
          # Character-wise movement
          { on = "h";       run = "move -1"; desc = "Move back a character"; }
          { on = "l";       run = "move 1";  desc = "Move forward a character"; }
          { on = "<Left>";  run = "move -1"; desc = "Move back a character"; }
          { on = "<Right>"; run = "move 1";  desc = "Move forward a character"; }
          { on = "<C-b>";   run = "move -1"; desc = "Move back a character"; }
          { on = "<C-f>";   run = "move 1";  desc = "Move forward a character"; }
          # Word-wise movement
          { on = "b";     run = "backward";                    desc = "Move back to the start of the current or previous word"; }
          { on = "B";     run = "backward --far";              desc = "Move back to the start of the current or previous WORD"; }
          { on = "w";     run = "forward";                     desc = "Move forward to the start of the next word"; }
          { on = "W";     run = "forward --far";               desc = "Move forward to the start of the next WORD"; }
          { on = "e";     run = "forward --end-of-word";       desc = "Move forward to the end of the current or next word"; }
          { on = "E";     run = "forward --far --end-of-word"; desc = "Move forward to the end of the current or next WORD"; }
          { on = "<A-b>"; run = "backward";                    desc = "Move back to the start of the current or previous word"; }
          { on = "<A-f>"; run = "forward --end-of-word";       desc = "Move forward to the end of the current or next word"; }
          # Line-wise movement
          { on = "0";      run = "move bol";        desc = "Move to the BOL"; }
          { on = "$";      run = "move eol";        desc = "Move to the EOL"; }
          { on = "_";      run = "move first-char"; desc = "Move to the first non-whitespace character"; }
          { on = "^";      run = "move first-char"; desc = "Move to the first non-whitespace character"; }
          { on = "<C-a>";  run = "move bol";        desc = "Move to the BOL"; }
          { on = "<C-e>";  run = "move eol";        desc = "Move to the EOL"; }
          { on = "<Home>"; run = "move bol";        desc = "Move to the BOL"; }
          { on = "<End>";  run = "move eol";        desc = "Move to the EOL"; }
          # Delete
          { on = "<Backspace>"; run = "backspace";         desc = "Delete the character before the cursor"; }
          { on = "<Delete>";    run = "backspace --under"; desc = "Delete the character under the cursor"; }
          { on = "<C-h>";       run = "backspace";         desc = "Delete the character before the cursor"; }
          { on = "<C-d>";       run = "backspace --under"; desc = "Delete the character under the cursor"; }
          # Kill
          { on = "<C-u>"; run = "kill bol";      desc = "Kill backwards to the BOL"; }
          { on = "<C-k>"; run = "kill eol";      desc = "Kill forwards to the EOL"; }
          { on = "<C-w>"; run = "kill backward"; desc = "Kill backwards to the start of the current word"; }
          { on = "<A-d>"; run = "kill forward";  desc = "Kill forwards to the end of the current word"; }
          # Cut/Yank/Paste
          { on = "d"; run = "delete --cut";                              desc = "Cut selected characters"; }
          { on = "D"; run = [ "delete --cut" "move eol" ];              desc = "Cut until EOL"; }
          { on = "c"; run = "delete --cut --insert";                     desc = "Cut selected characters, and enter insert mode"; }
          { on = "C"; run = [ "delete --cut --insert" "move eol" ];     desc = "Cut until EOL, and enter insert mode"; }
          { on = "x"; run = [ "delete --cut" "move 1 --in-operating" ]; desc = "Cut current character"; }
          { on = "y"; run = "yank";                                      desc = "Copy selected characters"; }
          { on = "p"; run = "paste";                                     desc = "Paste copied characters after the cursor"; }
          { on = "P"; run = "paste --before";                            desc = "Paste copied characters before the cursor"; }
          # Undo/Redo
          { on = "u";     run = "undo"; desc = "Undo the last operation"; }
          { on = "<C-r>"; run = "redo"; desc = "Redo the last operation"; }
          # Help
          { on = "<F1>"; run = "help"; desc = "Open help"; }
        ];
        confirm.keymap = [
          { on = "<Esc>";   run = "close";          desc = "Cancel the confirm"; }
          { on = "<C-[>";   run = "close";          desc = "Cancel the confirm"; }
          { on = "<C-c>";   run = "close";          desc = "Cancel the confirm"; }
          { on = "<Enter>"; run = "close --submit"; desc = "Submit the confirm"; }
          { on = "n"; run = "close";          desc = "Cancel the confirm"; }
          { on = "y"; run = "close --submit"; desc = "Submit the confirm"; }
          { on = "k"; run = "arrow prev"; desc = "Previous line"; }
          { on = "j"; run = "arrow next"; desc = "Next line"; }
          { on = "<Up>";   run = "arrow prev"; desc = "Previous line"; }
          { on = "<Down>"; run = "arrow next"; desc = "Next line"; }
          # Help
          { on = "<F1>"; run = "help"; desc = "Open help"; }
        ];
        cmp.keymap = [
          { on = "<C-c>";   run = "close";                                      desc = "Cancel completion"; }
          { on = "<Tab>";   run = "close --submit";                             desc = "Submit the completion"; }
          { on = "<Enter>"; run = [ "close --submit" "input:close --submit" ]; desc = "Complete and submit the input"; }
          { on = "<A-k>"; run = "arrow prev"; desc = "Previous item"; }
          { on = "<A-j>"; run = "arrow next"; desc = "Next item"; }
          { on = "<Up>";   run = "arrow prev"; desc = "Previous item"; }
          { on = "<Down>"; run = "arrow next"; desc = "Next item"; }
          { on = "<C-p>"; run = "arrow prev"; desc = "Previous item"; }
          { on = "<C-n>"; run = "arrow next"; desc = "Next item"; }
          # Help
          { on = "<F1>"; run = "help"; desc = "Open help"; }
        ];
        help.keymap = [
          { on = "<Esc>"; run = "escape"; desc = "Clear the filter, or hide the help"; }
          { on = "<C-[>"; run = "escape"; desc = "Clear the filter, or hide the help"; }
          { on = "<C-c>"; run = "close";  desc = "Hide the help"; }
          # Navigation
          { on = "k"; run = "arrow prev"; desc = "Previous line"; }
          { on = "j"; run = "arrow next"; desc = "Next line"; }
          { on = "<Up>";   run = "arrow prev"; desc = "Previous line"; }
          { on = "<Down>"; run = "arrow next"; desc = "Next line"; }
          # Filtering
          { on = "f"; run = "filter"; desc = "Filter help items"; }
        ];

      };
      theme = {
        icon.dirs = [
          { name = "Rust";      text = "󱘗"; }
          { name = "Obsidian";  text = ""; }
          { name = "Games";     text = "󰊗"; }
          { name = "Git";       text = ""; }
          { name = "LaTeX";     text = "󱛊"; }
          { name = "Documents"; text = "󱪗"; }
          { name = "Downloads"; text = ""; }
          { name = "Work";      text = ""; }
          { name = "Pictures";  text = ""; }
          { name = "Books";     text = "󱉟"; }
        ];
      };
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
      colorschemes.nightfox.enable = true;

      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          name = "typst-preview.nvim";
          src = pkgs.vimPlugins.typst-preview-nvim;
        })
      ];

      performance.combinePlugins = {
        enable = true;
        standalonePlugins = [
          "typst-preview.nvim"
        ];
      };

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
        { action = "<C-w>l";                         key = "<C-l>";      options.desc = "sd1"; }
        { action = "<C-w>h";                         key = "<C-h>";      options.desc = "sd4"; }
        { action = "<C-w>j";                         key = "<C-j>";      options.desc = "sd3"; }
        { action = "<C-w>k";                         key = "<C-k>";      options.desc = "sd2"; }
        { action = "<cmd>noh<CR>";                   key = "<Esc><Esc>"; options.desc = "which_key_ignore"; }
        { action = "<cmd>BufferLineCloseOthers<CR>"; key = "<leader>bo"; options.desc = "Close other buffers"; }
        { action = "<cmd>bdelete<CR>";               key = "<leader>bd"; options.desc = "Close buffer"; }
        { action = "<cmd>bnext<CR>";                 key = "<S-l>";      options.desc = "Move to right tab"; }
        { action = "<cmd>bprev<CR>";                 key = "<S-h>";      options.desc = "Move to left tab"; }
        { action = "<cmd>Telescope live_grep<CR>";   key = "<leader>lg"; options.desc = "Live Grep"; }
        { action = "<cmd>LazyGitCurrentFile<CR>";    key = "<leader>g";  options.desc = "LazyGit"; }
        { action = "<cmd>Yazi<cr>";                  key = "<leader>f";  options.desc = "Yazi"; }
        { action = "<cmd>wq<CR>";                    key = "<leader>qq"; options.desc = "Save and quit"; }
        { action = "<cmd>UndotreeToggle<CR>";        key = "<leader>u";  options.desc = "Toggle UndoTree"; }
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
        typst-vim = {
          enable = true;
          keymaps.watch = "<leader>w";
          settings = {
            pdf_viewer = "sioyek";
          };
        };
        ltex-extra = {
          enable = true;
          settings = {
            initCheck = true;
            loadLangs = [
              "en-US"
              "uk-UA"
            ];
            logLevel = "non";
            path = ".ltex";
          };
        };
        undotree = {
          enable = true;
          settings = {
            CursorLine = true;
            DiffAutoOpen = true;
            DiffCommand = "diff";
            DiffpanelHeight = 10;
            HelpLine = true;
            HighlightChangedText = true;
            HighlightChangedWithSign = true;
            HighlightSyntaxAdd = "DiffAdd";
            HighlightSyntaxChange = "DiffChange";
            HighlightSyntaxDel = "DiffDelete";
            RelativeTimestamp = true;
            SetFocusWhenToggle = true;
            ShortIndicators = false;
            SplitWidth = 40;
            TreeNodeShape = "*";
            TreeReturnShape = "\\";
            TreeSplitShape = "/";
            TreeVertShape = "|";
            WindowLayout = 4;
          };
        };


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
          settings = {
            check_ts = true;
            disable_filetype = [
              "TelescopePrompt"
            ];
            fast_wrap = {
              end_key = "$";
              map = "<M-e>";
              chars = [
                "\$"
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
        colorizer = {
          enable = true;
          settings.user_default_options = {
            AARRGGBB = true;
            RRGGBBAA = true;
            RGB = true;
            names = false;
          };
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
            ltex.enable = true;
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
            # imaps = {
            #   disabled = [];
            #   list = [
            #     "fr \\fraction\{\}\{\}"
            #   ];
            # };
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
