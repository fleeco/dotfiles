{ nix-vscode-extensions, dooted, pkgs, ... }:
let
  extensions = nix-vscode-extensions.extensions.x86_64-linux;
in
{
  programs.vscode = {
    enable = true;
    # package = pkgs.vscode.fhs;
    mutableExtensionsDir = false;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    userSettings = {
      "git.autofetch" = true;
      "explorer.confirmDelete" = false;
      "terminal.integrated.fontSize" = 12;
      "terminal.integrated.fontFamily" = "MesloLGS Nerd Font";
      "editor.fontFamily" = "MesloLGS Nerd Font";
      "editor.fontSize" = 14;
      "editor.formatOnSave" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };

    };

    extensions = [
      extensions.vscode-marketplace.jnoortheen.nix-ide
      extensions.vscode-marketplace.esbenp.prettier-vscode
      extensions.vscode-marketplace.ms-azuretools.vscode-docker
    ];
  };

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };

  home.packages = [
    pkgs.nixpkgs-fmt
    pkgs.kubectl
    # pkgs.dotnet-sdk_8
  ];
}
