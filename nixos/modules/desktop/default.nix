{ pkgs, ... }: {
  imports = [
    ./dunst
    ./hyprland.nix
    ./xdg.nix
    ./waybar.nix
    ./gtk.nix
    ./obs.nix
  ];

  home.packages = [
    pkgs.pavucontrol
    pkgs.dolphin
    pkgs.wofi
    pkgs.nwg-look
    pkgs.adw-gtk3
    pkgs.grimblast
    pkgs.wl-clipboard
  ];
}
