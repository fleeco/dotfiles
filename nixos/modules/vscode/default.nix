{ nix-vscode-extensions, dooted, pkgs, theme, ... }:
let
  extensions = nix-vscode-extensions.extensions.x86_64-linux;
in
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    userSettings = {
      "workbench.colorTheme" = "Catppuccin ${theme}";
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
      pkgs.catppuccin-vsc
      pkgs.vscode-marketplace.jnoortheen.nix-ide
      pkgs.vscode-marketplace.esbenp.prettier-vscode
      pkgs.vscode-marketplace.ms-azuretools.vscode-docker
      pkgs.vscode-marketplace.catppuccin.catppuccin-vsc-icons
      pkgs.vscode-extensions.github.copilot
      pkgs.vscode-extensions.github.copilot-chat
    ];
  };

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };

  home.packages = [
    pkgs.nixpkgs-fmt
    pkgs.kubectl
    # pkgs.dotnet-sdk_8
  ];
}
