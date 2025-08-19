{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    # nix-darwin for macOS system configuration
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    
    # home-manager for user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nix-darwin, home-manager, ... }: {
    # NixOS configurations (Linux)
    nixosConfigurations = {
      nova = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nova/nix/configuration.nix
        ];
      };
    };

    # nix-darwin configurations (macOS)
    darwinConfigurations = {
      sol = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/sol/darwin.nix
        ];
      };
    };

    # Home Manager configurations
    homeConfigurations = {
      "shin@sol" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [
          ./hosts/sol/home.nix
        ];
      };
    };
  };
}
