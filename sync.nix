{ config, pkgs, nixpkgs-stable, inputs, lib, ... }:
{
  imports = [
    ./default.nix
  ];

  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        "phone" = { id = "TVV4OKR-JCDYDZQ-3EFMNF2-ZIXBPYO-XRIJVGO-4OCOLAO-S3IQGGK-IXLNPAK"; };
        "pc" = { id = "EKSQELD-DFRSA35-C3LCKGA-IBOUVLL-EYGJCRC-ABUV73T-SGFP5OZ-IAAQGAB";};
      };
      folders = {
        "Obsidian" = { path = "/home/mlys/Obsidian"; devices = [ "phone" ]; };
        "Work" = { path = "/home/mlys/Work"; devices = [ "phone" ]; };
        # "Rust" = { path = "/home/mlys/Rust"; devices = [ "phone" ]; };
        "LaTeX" = { path = "/home/mlys/LaTeX"; devices = [ "phone" ]; };
        "Books" = { path = "/home/mlys/Books"; devices = [ "pc" ]; };
        # "Git" = { path = "/home/mlys/Git"; devices = [ "phone" ]; };
      };
    };
  };

}
