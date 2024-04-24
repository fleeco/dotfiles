{
  description = "NixOS Flake Configuration for Home";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    catppuccin.url = "github:catppuccin/nix";
    catppuccin-waybar = {
      url = "github:catppuccin/waybar";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-vscode-extensions, ... }@inputs:
    {
      nixosConfigurations. yeetdesk = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/yeetdesk/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager. useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.flees = {
              imports = [
                ./home.nix
                inputs.catppuccin.homeManagerModules.catppuccin
              ];
            };
            home-manager.extraSpecialArgs = {
              theme = "Mocha";
              inherit inputs;
              inherit nix-vscode-extensions;
            };
          }
        ];
      };
    };
}


