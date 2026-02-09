{ config, pkgs, ... }:
{
  imports = [
    ./default.nix
  ];

  services = {
    # Notifications aboba
    mako = {
      enable = true;
      settings = {
        font = config.default.main-font;
        default-timeout = 4000;
        background-color = "#${config.default.colors.background}";
        border-color = "#${config.default.colors.border}";
      };
    };
  };

  programs = {
    # Application launcher
    fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "${config.default.main-font}:size=12";
          terminal = "wezterm -e";
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
    };

    # Status bar
    waybar = {
      enable = true;
      settings = {
        mainBar = {
          name = "topbar";
          layer = "top";
          position = "top";
          height = 35;
          modules-left = [
            "battery#bat1"
            "battery#bat2"
            "disk"
            "memory"
            "cpu"
            "temperature"
            "custom/easyeffects"
            "custom/pyradio"
            "custom/blueman"
            "backlight"
          ];
          modules-center = [ "tray" ];
          modules-right = [
            "hyprland/language"
            "hyprland/workspaces"
            "network#vpn"
            "network#wifi"
            "network#ethernet"
            "network#disconnected"
            "clock"
            "custom/poweroff"
          ];
          "hyprland/language" = {
            format = "{}";
            format-en = "🇺🇸";
            format-uk = "🇺🇦";
            format-ru = "ᵣu";
          };
          "hyprland/workspaces" = {
            format = "{icon}";
            all-outputs = true;
            format-icons = {
              "1" = " "; # 
              "2" = "󱣛 "; # 󱣛
              "3" = "󰡱 "; # 󰊗
              "4" = "󰊗 "; # 󰡱
              "5" = "󰄻 "; # 󰄻
              "6" = "󰃻"; # 󰃻"
            };
            persistent-workspaces = {
              "*" = 6;
            };
          };
          "clock" = {
            interval = 1;
            format = "<b>{:%H:%M:%S}</b>";
            format-alt = "{:%Y-%m-%d}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };
          "cpu" = {
            format = " {usage}%";
            tooltip = false;
            on-click = "wezterm -e btop";
          };
          "disk" = {
            format = " {}%";
            tooltip-format = "{used} / {total} used";
            on-click = "wezterm -e dua interactive";
          };
          "memory" = {
            format = " {}%";
            tooltip-format = "{used:0.1f}G / {total:0.1f}G used";
          };
          "temperature" = {
            critical-threshold = 80;
            format = "{icon} {temperatureC}°C";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };
          "backlight" = {
            device = "intel_backlight";
            interval = 1;
            on-scroll-down = "brightnessctl --device='amdgpu_bl1' s +128";
            on-scroll-up = "brightnessctl --device='amdgpu_bl1' s 128-";
            format = "{icon} {percent}%";
            format-icons = [
              ""
              ""
            ];
            on-click = "wdisplays";
          };
          "battery#bat1" = {
            bat = "BAT0";
            adapter = "AC";
            interval = 10;
            full-at = 99;
            states = {
              full = 100;
              good = 99;
              empty = 5;
            };
            format = "{icon} {capacity}%";
            format-charging = " {capacity}%";
            format-plugged = " {capacity}%";
            format-empty = "";
            format-full = "";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };
          "battery#bat2" = {
            bat = "BAT1";
            adapter = "AC";
            interval = 10;
            states = {
              full = 100;
              good = 99;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = " {capacity}%";
            format-plugged = " {capacity}%";
            format-full = "";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };
          "network#disconnected" = {
            tooltip-format = "No connection!";
            format-ethernet = "";
            format-wifi = "";
            format-linked = "";
            format-disconnected = "";
            on-click = "nm-connection-editor";
          };
          "network#ethernet" = {
            interface = "enp*";
            format-ethernet = " 󰈀 ";
            format-wifi = "";
            format-linked = "";
            format-disconnected = "";
            tooltip-format = "{ifname}: {ipaddr}/{cidr}";
            on-click = "nm-connection-editor";
          };
          "network#wifi" = {
            interface = "wlp*";
            format-ethernet = "";
            format-wifi = "  {essid} ({signalStrength}%)";
            format-linked = "";
            format-disconnected = "";
            tooltip-format = "{ifname}: {ipaddr}/{cidr}";
            on-click = "nm-connection-editor";
          };
          "network#vpn" = {
            interface = "tun0";
            format = "";
            format-disconnected = "";
            tooltip-format = "{ifname}: {ipaddr}/{cidr}";
            on-click = "nm-connection-editor";
          };
          "custom/easyeffects" = {
            tooltip = false;
            format = "  ";
            on-click = "easyeffects";
          };
          "custom/blueman" = {
            tooltip = false;
            format = "󰂯";
            on-click = "blueman-manager";
          };
          "custom/pyradio" = {
            tooltip = false;
            format = "  ";
            on-click = "wezterm -e pyradio";
          };
          "custom/poweroff" = {
            tooltip = false;
            format = " ";
            on-click = "systemctl poweroff";
          };
        };
      };
      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: "${config.default.term-font}", "${config.default.term-font}";
        font-size: 16px;
          min-height: 0;
        }

        window#waybar {
          background-color: #${config.default.colors.background};
          color: #${config.default.colors.text};
          transition-property: background-color;
          transition-duration: .5s;
        }

        window#waybar.empty {
          color: rgba(0,0,0,0);
        }

        .topbar {
          border-bottom: 3px solid #${config.default.colors.border};
        }

        #workspaces button {
        padding: 0 3px;
        }

        #workspaces button:hover {
          box-shadow: inherit;
          text-shadow: inherit;
        }

        #workspaces button.visible {
          background: #90b1b1;
          color: #ffffff;
        }

        #workspaces button.current_output.visible {
          background: #90b1b1;
          color: #ffffff;
        }

        #workspaces button.current_output.focused {
          background: #ff0088;
        }

        #mode {
          background-color: #64727D;
          border-top: 3px solid #ffffff;
        }

        #backlight,
        #battery.bat1,
        #battery.bat2,
        #clock,
        #cpu,
        #custom-mail,
        #custom-poweroff,
        #custom-weather,
        #disk,
        #idle_inhibitor,
        #memory,
        #mode,
        #network.vpn,
        #network.wifi,
        #network.ethernet,
        #network.disconnected,
        #pulseaudio,
        #taskbar,
        #temperature,
        #tray {
        padding: 0 6px;
        margin: 0 0px;
        color: #ffffff;
        }

        @keyframes blink {
          to {
            background-color: #ffffff;
            color: #000000;
          }
        }

        #battery.bat2.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #temperature.critical {
          background-color: #eb4d4b;
        }
      '';
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];
    settings = {
      decoration = {
        rounding = "0";
        active_opacity = "1.0";
        inactive_opacity = "1.0";
        shadow.enabled = false;
        blur = {
          enabled = false;
          size = "3";
          passes = "1";
          vibrancy = "0.1696";
        };
      };
      exec-once = [
        "wbg -s ${./assets/.wallpaper.svg}"
        "waybar"
        "easyeffects --gapplication-service"
        "vesktop --start-minimized"
        "Telegram -startintray"
        "udiskie"
        "hyprctl setcursor ${config.default.cursor.name} 24"
        "wezterm -e aerc"
        "obsidian"
      ];
      env = [
        "CLUTTER_BACKEND,wayland"
        "GDK_BACKEND,wayland"
        "GDK_DEBUG,portals"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,gtk3"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "MOZ_ENABLE_WAYLAND,1"
        "GDK_SCALE,auto"
        "GTK_USE_PORTAL=1"
      ];
      general = {
        gaps_in = "2";
        gaps_out = "5";
        border_size = "1";
        "col.active_border" = "rgba(${config.default.colors.border}ff)";
        "col.inactive_border" = "rgba(${config.default.colors.background}ff)";
        resize_on_border = false;
        allow_tearing = true;
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
        vfr = true;
      };
      input = {
        kb_layout = "us,ua,ru"; # ,ru
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:alt_shift_toggle, caps:super";
        kb_rules = "";
        follow_mouse = "1";
        sensitivity = "0.2";
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
        };
        # force_no_accel = true;
        repeat_delay = 300;

      };
      # monitor = ",1920x1080,auto,1.2";


      "$mainMod" = "SUPER";
      "$terminal" = "wezterm";
      "$menu" = "fuzzel";

      bind = [
        # screenshot of a region
        ''$mainMod, S, exec, grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png ''
        # screenshot of the whole screen
        ''$mainMod SHIFT, S, exec, grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png''
        "$mainMod, Q, exec, $terminal"
        "$mainMod, Z, exec, woomer"
        "$mainMod, A, killactive,"
        "$mainMod, R, exec, $terminal -e yazi"
        "$mainMod, N, exec, $terminal -e nvim"
        "$mainMod, C, exec, $terminal -e clipse"
        "$mainMod, M, exec, $menu"
        "$mainMod, Z, exec, woomer"
        "$mainMod, T, togglefloating,"
        "$mainMod, F, fullscreen,"

        "$mainMod CTRL, l, resizeactive, 40 0"
        "$mainMod CTRL, h, resizeactive, -40 0"
        "$mainMod CTRL, k, resizeactive, 0 -40"
        "$mainMod CTRL, j, resizeactive, 0 40"
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

        "$mainMod, SPACE, exec, $(hyprctl activewindow -j | jq '.floating') && hyprctl dispatch cyclenext tiled || hyprctl dispatch cyclenext floating"

      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

}
