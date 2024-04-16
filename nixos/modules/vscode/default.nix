{ pkgs, ... }: {

  programs.vscode = {
    enable = true;
    userSettings = {
      "git.autofetch" = true;
      "explorer.confirmDelete" = false;
      "terminal.integrated.fontSize" = 12;
      "terminal.integrated.fontFamily" = "MesloLGS Nerd Font";
      "editor.fontFamily" = "MesloLGS Nerd Font";
      "editor.fontSize" = 14;
      "editor.formatOnSave" = true;
    };
    extensions = [
      pkgs.vscode-extensions.jnoortheen.nix-ide
    ];
  };

}
