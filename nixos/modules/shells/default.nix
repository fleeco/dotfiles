{ pkgs, ... }: {

  imports = [
    ./bash.nix
    ./alacritty
  ];

  programs.atuin = {
    enable = true;
    settings = {
      enter_accept = false;
      style = "compact";
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent "~/.1password/agent.sock"
    '';
  };

  programs.git = {
    enable = true;
    userName = "steveflee";
    userEmail = "steveflee@gmail.com";
  };

  programs.starship = {
    enable = true;
    catppuccin.enable = true;
  };

  home.shellAliases = {

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
}
