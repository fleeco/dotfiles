{ pkgs, ... }: {

  imports = [
    ./bash.nix
    ./alacritty
  ];

  home.shellAliases = {
    # Rebuilds, and gets rid of all generations except the last 5
    nrb = ''echo "Building off of the flake" && \
            cd ~/code/personal/dotfiles && \
            git add . && \
            sudo nixos-rebuild switch --flake nixos/ && \
            echo "Deleting all generations minus the previous 5" && \
            sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5 && \
            sudo nix-collect-garbage --delete-older-than 2d && \
            echo "Current generations available:" && \
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
    '';
  };

  programs.starship = {
    enable = true;
    catppuccin.enable = true;
  };
}
