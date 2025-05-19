-- You can configure your bookmarks by lua language
local bookmarks = {}

local path_sep = package.config:sub(1, 1)
local home_path = ya.target_family() == "windows" and os.getenv("USERPROFILE") or os.getenv("HOME")
if ya.target_family() == "windows" then
  table.insert(bookmarks, {
    tag = "Scoop Local",
    
    path = (os.getenv("SCOOP") or home_path .. "\\scoop") .. "\\",
    key = "p"
  })
  table.insert(bookmarks, {
    tag = "Scoop Global",
    path = (os.getenv("SCOOP_GLOBAL") or "C:\\ProgramData\\scoop") .. "\\",
    key = "P"
  })
end
table.insert(bookmarks, {
  tag = "Desktop",
  path = home_path .. path_sep .. "Desktop" .. path_sep,
  key = "d"
})

require("yamb"):setup {
  -- Optional, the path ending with path seperator represents folder.
  bookmarks = bookmarks,
  -- Optional, recieve notification everytime you jump.
  jump_notify = true,
  -- Optional, the cli of fzf.
  cli = "fzf",
  -- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
  keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
  -- Optional, the path of bookmarks
  path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\bookmark") or
        (os.getenv("HOME") .. "/.config/yazi/bookmark"),
}

require("full-border"):setup()

require("yatline"):setup({
    section_separator = { open = "", close = "" },
    part_separator = { open = "", close = "" },
    inverse_separator = { open = "", close = "" },

    style_a = {
        fg = "#1e2030",  -- Replace with Catppuccin Macchiato color
        bg_mode = {
            normal = "#89B4FA",  -- Replace with Catppuccin Macchiato color
            select = "#6e738d",  -- Replace with Catppuccin Macchiato color
            un_set = "#d9e0ee"   -- Replace with Catppuccin Macchiato color
        }
    },
    style_b = { bg = "#2f334d", fg = "#c6d0f5" },  -- Replace with Catppuccin Macchiato colors
    style_c = { bg = "#24273a", fg = "#a5adcb" },  -- Replace with Catppuccin Macchiato colors

    permissions_t_fg = "#8aadf4",  -- Replace with Catppuccin Macchiato color
    permissions_r_fg = "#f5a97f",  -- Replace with Catppuccin Macchiato color
    permissions_w_fg = "#ed8796",  -- Replace with Catppuccin Macchiato color
    permissions_x_fg = "#a6da95",  -- Replace with Catppuccin Macchiato color
    permissions_s_fg = "#494d64",  -- Replace with Catppuccin Macchiato color

    tab_width = 20,
    tab_use_inverse = false,

    selected = { icon = "󰻭", fg = "#f5a97f" },  -- Replace with Catppuccin Macchiato color
    copied = { icon = "", fg = "#a6da95" },    -- Replace with Catppuccin Macchiato color
    cut = { icon = "", fg = "#ed8796" },       -- Replace with Catppuccin Macchiato color

    total = { icon = "󰮍", fg = "#f5a97f" },    -- Replace with Catppuccin Macchiato color
    succ = { icon = "", fg = "#a6da95" },     -- Replace with Catppuccin Macchiato color
    fail = { icon = "", fg = "#ed8796" },     -- Replace with Catppuccin Macchiato color
    found = { icon = "󰮕", fg = "#8aadf4" },    -- Replace with Catppuccin Macchiato color
    processed = { icon = "󰐍", fg = "#a6da95" },-- Replace with Catppuccin Macchiato color

    show_background = true,

    display_header_line = true,
    display_status_line = true,

    header_line = {
        left = {
            section_a = {
                    {type = "line", custom = false, name = "tabs", params = {"left"}},
            },
            section_b = {
            },
            section_c = {
            }
        },
        right = {
            section_a = {
                    {type = "string", custom = false, name = "date", params = {"%A, %d %B %Y"}},
            },
            section_b = {
                    {type = "string", custom = false, name = "date", params = {"%X"}},
            },
            section_c = {
            }
        }
    },

    status_line = {
        left = {
            section_a = {
                    {type = "string", custom = false, name = "tab_mode"},
            },
            section_b = {
                    {type = "string", custom = false, name = "hovered_size"},
            },
            section_c = {
                    {type = "string", custom = false, name = "hovered_name"},
                    {type = "coloreds", custom = false, name = "count"},
            }
        },
        right = {
            section_a = {
                    {type = "string", custom = false, name = "cursor_position"},
            },
            section_b = {
                    {type = "string", custom = false, name = "cursor_percentage"},
            },
            section_c = {
                    {type = "string", custom = false, name = "hovered_file_extension", params = {true}},
                    {type = "coloreds", custom = false, name = "permissions"},
            }
        }
    },
})
