{ config, lib, inputs, pkgslocal, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.overlays = [
    inputs.catppuccin-vsc.overlays.default
  ];

  programs.dconf.enable = true;
  networking.hostName = "yeetdesk";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgslocal.linuxPackages_latest;
  boot.extraModulePackages = [ pkgslocal.linuxPackages_latest.kvmfr inputs.macbook12-spi-driver ];

  boot.kernel.sysctl."max_user_instances" = 8192;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };


  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  virtualisation.docker.enable = true;

  time.timeZone = "US/Pacific";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    keyMap = "dvorak";
  };

  # The exact same shit in home manager...did not work.  WTF.
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  users.users.flees = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "flees" ];
  };

  services.openssh.enable = true;
  system.stateVersion = "24.05";
}

