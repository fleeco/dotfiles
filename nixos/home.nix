{ pkgs, ... }: {

  imports = [
    ./modules/desktop
    ./modules/shells
    ./modules/vscode
  ];

  fonts.fontconfig.enable = true;

  programs.awscli = {
    enable = true;
    settings = {
      "revcontent" = {
        region = "us-west-2";
        output = "json";
      };
    };
    credentials = {
      "revcontent" = {
        "credential_process" = ''
          sh -c 'echo "{\"Version\": 1, \"AccessKeyId\": \"$(op read "op://Personal/rc_aws_creds/access key id")\", \"SecretAccessKey\": \"$(op read "op://Personal/rc_aws_creds/secret access key")\"}"'
        '';
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
    pkgs.nixpkgs-fmt
    pkgs.discord
    pkgs.signal-desktop

    pkgs.keyd
    # We don't want to install all of nerdfonts in it's entirety
    (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; })
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

