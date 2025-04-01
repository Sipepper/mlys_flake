{ config, pkgs, nixpkgs-stable, inputs, lib, ... }:
{
  imports = [
    ./default.nix
  ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        name = "topbar";
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [
          "battery#bat1" 
          "battery#bat2" 
          "disk" 
          "memory" 
          "cpu" 
          "custom/easyeffects" 
          "custom/pyradio" 
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
            "1" = "";
            "2" = "󱣛";
            "3" = "󰊗";
            "4" = "󰡱";
            "5" = "󰄻";
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
          on-click = "kitty -e --class=btop btop";
        };
        "disk" = {
          format = " {}%";
          tooltip-format = "{used} / {total} used";
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
        "custom/pyradio" = {
          tooltip = false;
          format = " ";
          on-click = "kitty --class=pyradio -e pyradio";
        };
        "custom/poweroff" = {
          tooltip = false;
          format = "";
          on-click = "systemctl poweroff";
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: ${config.default.main-font}, "Font Awesome 6 Free Solid";
        font-size: 13px;
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
}
