# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{config, pkgs, inputs, ... }:
{ 
  imports =
    [ # Include the results of the hardware scan. ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ./hardware-configuration.nix
      ./main-user.nix
    ];

  fonts.packages = with pkgs; [ 
    nerd-fonts.hurmit 
    nerd-fonts.droid-sans-mono
    nerd-fonts.iosevka
    corefonts
    vistafonts
  ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    PAGER = "bat --plain";
    MANPAGER = "bat --plain";
    NIXOS_OZONE_WL = 1;
    GSETTINGS_SCHEMA_DIR = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
    NNN_FIFO = "/tmp/nnn.fifo";
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
    pkgs.cargo-expand 
    pkgs.cargo-fuzz   
    pkgs.evcxr 
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Iosevka NF";
      fontSize = "12";
    })

    pkgs.gtk3
    pkgs.adwaita-icon-theme
    pkgs.gsettings-desktop-schemas

  ];

  main-user.enable = true;
  main-user.userName = "mlys";

  xdg.mime = {
    enable = true;
    # removedAssociations = { 
    #   "inode/directory" = "kitty-open.desktop";
    # };
    defaultApplications = {
      "inode/directory" = "thunar.desktop";
      "application/x-directory" = "thunar.desktop";
      "application/pdf" = "sioyek.desktop";
      "application/xopp" = "xournal.desktop";
      "application/x-genesis-rom" = "kega-fusion.desktop";
      "text/plain" = "nvim.desktop";
      "text/markdown" = "nvim.desktop";
    };
  };

  services = {
    preload.enable = true;

    # Enable automatic login for the user.
    getty.autologinUser = "mlys";

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
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
    # nh = {
    #   enable = true;
    #   clean.enable = true;
    #   clean.extraArgs = "--keep-since 4d --keep 3";
    #   flake = builtins.toString ./.;
    # };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [ ];
    };

    dconf.enable = true;

    gamescope.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };	

    seahorse.enable = true;
    gamemode.enable = true;
    thunar.enable = true;
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
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    amdgpu.opencl.enable = true;
  };

  security = {
    pam.services.login.enableGnomeKeyring = true;
    rtkit.enable = true;
    polkit.enable = true;
  };


  # boot.loader.systemd-boot.enable = true;
  boot.loader = {
    grub = {
      enable = true; 
      efiSupport = true;
      device = "nodev";
      splashImage = ./assets/grub.jpg;
      font = "${pkgs.nerd-fonts.hurmit}/share/fonts/opentype/NerdFonts/Hurmit/HurmitNerdFont-Regular.otf";
      fontSize = 16;
    };
    efi.canTouchEfiVariables = true;
  };


  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  time.timeZone = "Europe/Kyiv";

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

  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024;
  }];


  system.stateVersion = "24.05"; # Did you read the comment?

  system.switch.enableNg = true;

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    dates = "11:00";
    randomizedDelaySec = "45min";
  };

  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";

  fileSystems."/home/mlys/Sata" = {
    device = "/dev/sdb1";
    autoFormat = true;
  };

}
