{ config, pkgs, nixpkgs-stable, inputs, lib, ... }:
{
  imports = [
    ./default.nix
  ];

  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        "phone" = { id = "F76YWQC-6F5ADDO-X6QO4XV-4AWXYKI-M47JE2Z-EMKKIES-7DUMMMC-GIEN3AJ"; };
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
