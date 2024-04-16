{ pkgs, ... }: {
  imports = [
    ./hyprland.nix
    ./xdg.nix
    ./waybar.nix
  ];

  home.packages = [
    pkgs.pavucontrol
    pkgs.wofi
  ];
}
