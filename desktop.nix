{ config, pkgs, nixpkgs-stable, inputs, lib, ... }:
{
  imports = [
    ./default.nix
  ];

  services = {
    # background image for hyprland
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;
        preload = [ ".space.jpg" ];
        wallpaper = [ ", .space.jpg" ];
      };
    };
    # Notifications
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
    # cli calendar
    khal.enable = true;
    qcal.enable = true;
    # Application launcher
    fuzzel = {
      enable = true;
      settings = {
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
          modules-center = ["tray"];
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
              "1" = " ";
              "2" = "󱣛 ";
              "3" = "󰊗 ";
              "4" = "󰡱 ";
              "5" = "󰄻 ";
              "6" = "󰃻";
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
            on-click = "kitty -e --class=btop -o font_size=8 btop";
          };
          "disk" = {
            format = " {}%";
            tooltip-format = "{used} / {total} used";
            on-click = "kitty -e --class=dua -o font_size=8 dua interactive";
          };
          "memory" = {
            format = " {}%";
            tooltip-format = "{used:0.1f}G / {total:0.1f}G used";
          };
          "temperature" = {
            critical-threshold = 80;
            format = "{icon} {temperatureC}°C";
            format-icons = ["" "" "" "" ""];
          };
          "backlight" = {
            device = "intel_backlight";
            interval = 1;
            on-scroll-down = "brightnessctl --device='amdgpu_bl1' s +1";
            on-scroll-up = "brightnessctl --device='amdgpu_bl1' s 1-";
            format = "{icon} {percent}%";
            format-icons  = ["" ""];
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
            format-icons = ["" "" "" "" ""];
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
            format-icons = ["" "" "" "" ""];
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
            format-wifi = " {essid} ({signalStrength}%)";
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
            on-click = "kitty --class=pyradio -e pyradio";
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
        font-family: "${config.default.main-font}", "Font Awesome 6 Free Solid";
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
        "waybar"
        "hyprpaper"
        "steam -silent -forcedesktopscaling" # Add dependenyc of isPC
        "slack -u"
        "easyeffects --gapplication-service"
        "discord --start-minimized"
        "Telegram -startintray"
        "udiskie"
        "hyprctl setcursor ${config.default.cursor.name} 24"
        "kitty -e aerc"
      ];
      env = [
        "CLUTTER_BACKEND,wayland"
        "GDK_BACKEND,wayland,x11"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,gtk3"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "MOZ_ENABLE_WAYLAND,1"
        "GDK_SCALE,auto"
        "GTK_USE_PORTAL=1"
        "GSETTINGS_SCHEMAS_DIR,${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
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
      gestures.workspace_swipe = false; 
      device = {
        name = "e-signal-hator-pulsar";
        sensitivity = "-0.5";
      };
      monitor = ",1920x1080,auto,auto";

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
        "$mainMod, O, exec, obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland"
        # "$mainMod, O, exec, obsidian"
        "$mainMod, C, killactive,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, R, exec, $terminal --class=yazi -e yazi"
        "$mainMod, N, exec, kitty -e nvim"
        "$mainMod, G, exec, kega-fusion"
        "$mainMod, M, exec, $menu"
        "$mainMod, F, exec, firefox"
        "$mainMod, T, exec, Telegram"
        # "$mainMod, S, exec, $terminal -o \"font_size 8.0\" -e sc-im"
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
        "float,        title:(Choose Files)"
        "float,        title:(Select Document)"
        "float,        title:(Choose modpack)"

        "float,        title:(Вхід)"
        "float,        title:(Login)"

        "float,        class:(.blueman-manager-wrapped)"


        "tile,         class:Aseprite"

        "float,        class:(timer)"
        "pin,          class:(timer)"
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
        # "size 800 400, title:(Save File)"

        "float,            class:(btop)"
        "move 1% 5%,       class:(btop)"
        "size <45% <55%,   class:(btop)"

        "float,          class:(terminal)"
        "center,         class:(terminal)"
        "size <40% <40%, class:(terminal)"

        # "float,          class:(nnn)"
        # "center,         class:(nnn)"
        # "size <40% <40%, class:(nnn)"

        "float,        title:(Picture-in-Picture)"
        "center,       title:(Picture-in-Picture)"
        "pin,          title:(Picture-in-Picture)"

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

}
