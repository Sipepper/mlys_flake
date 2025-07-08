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
        "laptop" = { id = "3RXTYVP-BCN2EDP-L5JK4VN-GPMKIMQ-MTURSLG-HSY2N7E-UL4B75X-SZVFUAQ";};
      };
      folders = {
        "Obsidian" = { path = "/home/mlys/Obsidian"; devices = [ "phone" ]; };
        "Work" = { path = "/home/mlys/Work"; devices = [ "phone" ]; };
        "Rust" = { path = "/home/mlys/Rust"; devices = [ "phone" ]; };
        "LaTeX" = { path = "/home/mlys/LaTeX"; devices = [ "phone" ]; };
        "Books" = { path = "/home/mlys/Books"; devices = [ "laptop" ]; };
        "Git" = { path = "/home/mlys/Git"; devices = [ "phone" ]; };
      };
    };
  };

}
