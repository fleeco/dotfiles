{ pkgs, ... }: {
  imports = [
    ./dunst
    ./hyprland.nix
    ./waybar.nix
    ./obs.nix
  ];

  programs.tmux = {
    enable = true;
    catppuccin.enable = true;
  };

  home.packages = [
    pkgs.pavucontrol
    pkgs.dolphin
    pkgs.wofi
    pkgs.grimblast
    pkgs.wl-clipboard
    pkgs.nwg-look
  ];
}
