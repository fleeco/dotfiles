{ config, pkgs, lib, theme, specialArgs, ... }:

{
  imports = [
    ../../modules/desktop/dunst
    ../../modules/shells
    #../../modules/desktop
    ../../modules/vscode
    ../../modules/nvim
  ];

  fonts.fontconfig.enable = true;

  catppuccin = {
    flavour = lib.toLower theme;
    accent = "pink";
  };

  home.username = "flees";
  home.homeDirectory = "/home/flees";

  programs.starship = {
    enable = true;

    settings = {
      kubernetes = {
        disabled = false;
      };
    };
  };

  programs.atuin = {
    enable = true;
    settings = {
      enter_accept = false;
      style = "compact";
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    ];
  };

  # The identity agent lets me use my ssh keys from 1password easy breezy
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };

  programs.git = {
    enable = true;
    userName = "Stephen Flee";
    userEmail = "steveflee@gmail.com";
  };


  home.packages = [
    pkgs.signal-desktop
    pkgs.waybar
    pkgs.btop
    pkgs.pavucontrol

    pkgs.roboto
    pkgs.nerdfonts

    pkgs.wl-clipboard
    pkgs.grimblast

    pkgs._1password
    pkgs._1password-gui

    pkgs.font-awesome
    pkgs.ytfzf

    # This is used for tide / fish
    (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    KUBECONFIG = /home/flees/.kube/config;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
