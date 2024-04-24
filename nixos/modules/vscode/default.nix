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
      "workbench.colorTheme" = "Catppuccin Mocha";
      "catppuccin.accentColor" = "pink";
      "git.autofetch" = true;
      "explorer.confirmDelete" = false;
      "editor.fontSize" = 14;
      "editor.formatOnSave" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };

      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.minimumContrastRatio" = 1;
      "window.titleBarStyle" = "custom";
      "gopls" = {
        "ui.semanticTokens" = true;
      };
    };

    extensions = [
      extensions.vscode-marketplace.jnoortheen.nix-ide
      extensions.vscode-marketplace.esbenp.prettier-vscode
      extensions.vscode-marketplace.ms-azuretools.vscode-docker
      extensions.vscode-marketplace.catppuccin.catppuccin-vsc
      extensions.vscode-marketplace.catppuccin.catppuccin-vsc-icons
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
