# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
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
    };
  };



  programs.dconf.enable = true;

  programs.gamescope.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };	
  main-user.enable = true;
  main-user.userName = "mlys";

  # Enable automatic login for the user.
  services.getty.autologinUser = "mlys";

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm = {
    wayland.enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };

  services.printing.enable = true;
  services.printing.drivers = [ 
    pkgs.samsung-unified-linux-driver 
    pkgs.splix 
    pkgs.gutenprint 
    pkgs.gutenprintBin
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.udisks2.enable = true;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  security.pam.services.login.enableGnomeKeyring = true;

  programs.seahorse.enable = true;

  boot.loader.systemd-boot.enable = true;
  # boot.loader.grub.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  services.xserver.autoRepeatInterval = 30;
  services.xserver.autoRepeatDelay = 100;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
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

  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    PAGER = "bat --plain";
    MANPAGER = "bat --plain";
    NIXOS_OZONE_WL = 1;
    GSETTINGS_SCHEMAS_DIR = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}";
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    system-config-printer
    nix-prefetch
    nix-prefetch-git
    gdb
    wget
    gcc_multi
    unzip
    udiskie
    fd
    sshfs
    xorg.xhost
    # Copied from https://github.com/RGBCube/NCC/blob/aec093b751cdf8d0170628e483923aae7773e3a5/modules/common/rust.nix
    cargo-expand 
    cargo-fuzz   
    evcxr 
    vulkan-volk
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools 
    # catppuccin-sddm.override {
    #   flavor = "macchiato";
    #   font  = pkgs.nerd-fonts.iosevka;
    #   fontSize = "12";
    # }
    catppuccin-sddm
    gtk3
    adwaita-icon-theme

  ];

  hardware.opentabletdriver.enable = true;

  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024;
  }];

  programs.kdeconnect.enable = true;
  programs.gamemode.enable = true;


  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  services.gnome.gnome-keyring.enable = true;


  # Some programs need SUID wrappers
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";

  fileSystems."/home/mlys/Sata" = {
    device = "/dev/sdb1";
    autoFormat = true;
  };

}
