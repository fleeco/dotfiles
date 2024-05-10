{ pkgs, lib, theme, gitbutler, ... }: {

  imports = [
    ../../modules/desktop
    ../../modules/shells
    ../../modules/vscode
    ../../modules/nvim
  ];

  systemd. user. startServices = true;
  fonts.fontconfig.enable = true;

  catppuccin = {
    flavour = lib.toLower theme;
    accent = "pink";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-${theme}-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = lib.toLower theme;
      };
    };
  };

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

  programs.looking-glass-client = {
    enable = true;
  };

  home.packages = [
    pkgs.slack
    pkgs.solaar
    pkgs.firefox
    pkgs.xdg-utils
    pkgs.btop
    pkgs.discord
    pkgs.signal-desktop
    pkgs.spotify
    pkgs.nh
    gitbutler.gitbutler-ui
    gitbutler.gitbutler
    # gitbutler
    # We don't want to install all of nerdfonts in it's entirety
    (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; })
  ];

  programs.neovim = {
    enable = true;
    catppuccin.enable = true;
  };

  home.stateVersion = "24.05";
}

