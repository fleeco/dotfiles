{ pkgs, ... }: {
  imports = [
    ./dunst
    ./hyprland.nix
    ./waybar.nix
    ./obs.nix
  ];

  home.packages = [
    pkgs.pavucontrol
    pkgs.dolphin
    pkgs.wofi
    pkgs.grimblast
    pkgs.wl-clipboard
  ];
}
