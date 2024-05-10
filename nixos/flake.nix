{
  description = "NixOS Flake Configuration for Home";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # This is while we are waiting for this PR to be merged
    # https://github.com/NixOS/nixpkgs/pull/289664
    gitbutler.url = "github:hacker1024/nixpkgs/package/gitbutler";

    catppuccin-vsc.url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz";

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

    # This is only required for non nixos installations
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      gitbutler = import inputs.gitbutler {
        system = "x86_64-linux";
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
      };
      theSpecials = {
        theme = "Macchiato";
        inherit gitbutler;
        inherit inputs;
      };


    in
    {
      nixosConfigurations.yeetdesk = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/yeetdesk/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.flees = {
              imports = [
                ./hosts/yeetdesk/home.nix
                inputs.catppuccin.homeManagerModules.catppuccin
              ];
            };
            home-manager.extraSpecialArgs = theSpecials;
          }
        ];
      };

      homeConfigurations."flees" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          config.allowUnfree = true;
          config.allowUnfreePredicate = (_: true);
          overlays = [
            inputs.nix-vscode-extensions.overlays.default
            inputs.nixgl.overlay
            inputs.catppuccin-vsc.overlays.default
          ];
        };

        modules = [
          ./hosts/yeetlap/home.nix
          inputs.catppuccin.homeManagerModules.catppuccin
        ];

        extraSpecialArgs = theSpecials;
      };
    };
}


