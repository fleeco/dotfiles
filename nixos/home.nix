{ pkgs, ... }: {

  imports = [
    ./modules/desktop
    ./modules/shells
    ./modules/vscode
  ];

  systemd.user.startServices = true;

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

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent "~/.1password/agent.sock"
    '';
  };

  home.packages = [
    pkgs.slack
    pkgs.firefox

    pkgs.btop
    pkgs.discord
    pkgs.signal-desktop

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

