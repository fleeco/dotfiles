{ pkgs, theme, nixpkgsmain, ... }: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    userSettings = {
      "workbench.colorTheme" = "Catppuccin ${theme}";
      "catppuccin.accentColor" = "pink";
      "git.autofetch" = true;
      "explorer.confirmDelete" = false;
      "editor.fontSize" = 14;
      "editor.formatOnSave" = true;
      "editor.fontFamily" = "MesloLGM Nerd Font Mono";
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
      "csharp.suppressBuildAssetsNotification" = true;
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.fontFamily" = "MesloLGM Nerd Font Mono";
      # "terminal.external.linuxExec" = "alacritty";
      # "terminal.explorerKind" = "external";
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
      pkgs.vscode-marketplace.ms-vscode-remote.remote-containers
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
  ];
}

