{
  description = "mlys config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # grub2-themes = {
    #   url = "github:vinceliuice/grub2-themes";
    # };
  };

  outputs = { 
    self, 
    nixpkgs, 
    home-manager, 
    determinate, 
    nixvim, 
    # grub2-themes,
    ... 
    }@inputs: {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          inputs.home-manager.nixosModules.default
          determinate.nixosModules.default
          # grub2-themes.nixosModules.default
        ];
      };
    };
  };
}
