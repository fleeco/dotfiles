{ pkgs, ... }: {
  imports = [
    ./hyprland.nix
    ./xdg.nix
    ./waybar.nix
  ];
}
