{
  description = "NixOS Flake Configuration for Home";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgsfork.url = "github:fleeco/nixpkgs";

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
    let
      pkgslocal = import inputs.nixpkgsfork {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations. yeetdesk = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit pkgslocal; };

        modules = [
          ./hosts/yeetdesk/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager. useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.flees = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit nix-vscode-extensions; };
          }
        ];
      };
    };
}


