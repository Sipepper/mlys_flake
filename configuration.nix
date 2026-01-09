{pkgs, inputs, ... }:
{ 
  imports =
    [ # Include the results of the hardware scan. ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ./hardware-configuration.nix
      ./main-user.nix
    ];

  fonts.packages = with pkgs; [ 
    nerd-fonts.droid-sans-mono
    nerd-fonts.iosevka-term
    (iosevka.override {
      set = "custom";
      privateBuildPlan = {
        family = "Iosevka Custom";
        spacing = "quasi-proportional";
        # serifs = "sans";
        serifs = "slab";
        noCvSs = true;
        exportGlyphNames = false;
        weights = {
          Regular = {
            shape = 400;
            menu = 400;
            css = 400;
          };
          Bold = {
            shape = 700;
            menu = 700;
            css = 700;
          };
        };
        slopes = {
          Upright = {
            angle = 0;
            shape = "upright";
            menu = "upright";
            css = "normal";
          };
          Italic = {
            angle = 9.4;
            shape = "italic";
            menu = "italic";
            css = "italic";
          };
        };
      };
    })
    corefonts
    vista-fonts
  ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    # TERMINAL = "kitty";
    TERMINAL = "wezterm";
    PAGER = "bat --plain";
    MANPAGER = "bat --plain";
    NIXOS_OZONE_WL = 1;
  };

  environment.systemPackages = [
    pkgs.wl-clipboard
    pkgs.system-config-printer
    pkgs.nix-prefetch
    pkgs.nix-prefetch-git
    pkgs.gdb
    pkgs.wget
    pkgs.gcc_multi
    pkgs.unzip
    pkgs.udiskie
    pkgs.fd
    pkgs.sshfs
    pkgs.xorg.xhost
    pkgs.glib
    # Copied from https://github.com/RGBCube/NCC/blob/aec093b751cdf8d0170628e483923aae7773e3a5/modules/common/rust.nix
    pkgs.evcxr 

    pkgs.gtk3
    pkgs.adwaita-icon-theme
    pkgs.gsettings-desktop-schemas
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Iosevka Custom";
      fontSize = "12";
    })

  ];
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  main-user.enable = true;
  main-user.userName = "mlys";

  xdg.mime = {
    enable = true;
    # removedAssociations = { 
    #   "inode/directory" = "kitty-open.desktop";
    # };
    defaultApplications = {
      "inode/directory" = "yazi.desktop";
      "application/x-directory" = "yazi.desktop";
      "application/pdf" = "sioyek.desktop";
      "application/xopp" = "xournal.desktop";
      "application/x-genesis-rom" = "kega-fusion.desktop";
      "text/plain" = "nvim.desktop";
      "text/markdown" = "nvim.desktop";
      "image/png" = "feh.desktop";
      "image/jpeg" = "feh.desktop";
      "image/svg" = "feh.desktop";
      "image/vnd.djvu+multipage" = "org.gnome.evince.desktop";
    };
  };

  services = {
    lact.enable = true;

    # Enable automatic login for the user.
    getty.autologinUser = "mlys";

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "catppuccin-mocha-mauve";
    };

    printing = {
      enable = true;
      drivers = [ 
        pkgs.samsung-unified-linux-driver 
        pkgs.splix 
        pkgs.gutenprint 
        pkgs.gutenprintBin
      ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    udisks2.enable = true;

    xserver = {
      autoRepeatInterval = 30;
      autoRepeatDelay = 100;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    gnome.gnome-keyring.enable = true;

    blueman.enable = true;
  };

  programs = {

    dconf.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      protontricks.enable = true;
    };	

    seahorse.enable = true;
    gamemode.enable = true;
    xfconf.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    # Some programs need SUID wrappers
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

  };

  hardware = {
    opentabletdriver.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = { 
        General.Experimental = true;
        General.FastConnectable = true;
        Policy.AutoEnable = true;
      };
    };
    amdgpu = {
      overdrive.enable = true;
      opencl.enable = true;
    };
    graphics.enable = true;

  };

  security = {
    pam.services.login.enableGnomeKeyring = true;
    rtkit.enable = true;
    polkit.enable = true;
  };


  boot.loader = {
    grub = {
      enable = true; 
      efiSupport = true;
      device = "nodev";
      splashImage = ./assets/grub.jpg;
      # font = "${pkgs.nerd-fonts.iosevka-term}/share/fonts/truetype/NerdFonts/IosevkaTerm/IosevkaTermNerdFont-Regular.ttf";
      fontSize = 16;
      useOSProber = true;
    };
    efi.canTouchEfiVariables = true;
  };


  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  time = {
    timeZone = "Europe/Kyiv";
    hardwareClockInLocalTime = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mlys = {
    isNormalUser = true;
    description = "Mykola Lysynskyi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      unzip
      vim
      kdePackages.print-manager
      gnomeExtensions.printers
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "mlys" = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024;
  }];


  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";

  fileSystems."/home/mlys/Sata" = {
    device = "/dev/sdb1";
    autoFormat = true;
  };

  fileSystems."/home/mlys/SSD" = {
    device = "/dev/sda1";
    autoFormat = true;
  };

}
