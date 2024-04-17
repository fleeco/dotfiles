{ pkgs, ... }: {
  imports = [
    ./dunst
    ./hyprland.nix
    ./xdg.nix
    ./waybar.nix
    ./gtk.nix
  ];

  home.packages = [
    pkgs.pavucontrol
    pkgs.wofi
    pkgs.nwg-look
    pkgs.adw-gtk3
  ];
}
