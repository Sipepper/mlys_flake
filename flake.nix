{
  description = "mlys config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      nixpkgs,
      determinate,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            ./hardware-desktop.nix
            determinate.nixosModules.default
            home-manager.nixosModules.default
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users."mlys" = {
                imports = [ ./home.nix ];
                wayland.windowManager.hyprland.settings.monitor = ",1920x1080@100,auto,1";
              };
            }
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            ./hardware-laptop.nix
            {
              swapDevices = [
                {
                  device = "/swapfile";
                  size = 16 * 1024;
                }
              ];
              system.stateVersion = "24.05"; # Did you read the comment?
            }
            determinate.nixosModules.default
            home-manager.nixosModules.default
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users."mlys" = {
                imports = [ ./home.nix ];
                wayland.windowManager.hyprland.settings.monitor = ",1920x1080,auto,1.2";
              };
            }
          ];
        };
      };
    };
}
