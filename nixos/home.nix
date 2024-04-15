{ pkgs, ...}: {
    
  fonts.fontconfig.enable = true;

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "hyprland"
        ];
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  home.shellAliases = {
    nrb = "sudo nixos-rebuild switch --flake ~/code/personal/dotfiles/nixos";
  };

  programs.starship = {
    enable = true;
  };

  programs.vscode = {
    enable = true;
    userSettings = {
      "git.autofetch" = true;
      "explorer.confirmDelete" = false;
      "terminal.integrated.fontSize" =  12;
      "terminal.integrated.fontFamily" =  "MesloLGS Nerd Font";
      "editor.fontFamily" =  "MesloLGS Nerd Font";
      "editor.fontSize" = 14;
      "editor.formatOnSave" = true;
    };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      source /home/flees/.config/op/plugins.sh
      #export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain codeartifact-default --domain-owner 939067023032 --region us-east-1 --query authorizationToken --output text`
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;
  };

  programs.awscli = {
    enable = true;
    settings = {
      "default" = {
        region = "us-west-2";
        output = "json";
      };
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.8;
        padding = {
          x = 10;
          y = 10;
        };
      };

      font = {
        size = 11;
        normal = {
          family = "Meslo LGS Nerdfont";
          style = "Regular";
        };
      };

    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent "~/.1password/agent.sock"
    '';
  };

  home.packages = [
    pkgs.wofi
    pkgs.slack
    pkgs.firefox
    pkgs.pavucontrol

    # We don't want to install all of nerdfonts in it's entirety
    (pkgs.nerdfonts.override { fonts = ["Meslo"]; })
  ];

  programs.vim = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "steveflee";
    userEmail = "steveflee@gmail.com";
  };

  home.stateVersion = "24.05";
}
