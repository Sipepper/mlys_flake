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
      };
      folders = {
        "Obsidian" = {
          path = "/home/mlys/Obsidian";
          devices = [ "phone" ];
        };
      };
    };
  };

}
