{ pkgs, ... }: {

  imports = [
    ./bash.nix
    ./alacritty.nix
  ];

  home.shellAliases = {
    nrb = "sudo nixos-rebuild switch --flake ~/code/personal/dotfiles/nixos";
  };

  programs.starship = {
    enable = true;
  };
}
