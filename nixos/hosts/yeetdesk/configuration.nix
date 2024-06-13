{ config, lib, inputs, pkgs, ... }:
let
  kvmfr = config.boot.kernelPackages.callPackage ../../pkgs/kvmfr { };
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
    inputs.nixgl.overlay
    inputs.catppuccin-vsc.overlays.default
    # Keeping this here just because it's neat
    # (final: prev: {
    #   awsvpnclient = inputs.awsvpnclient.packages.x86_64-linux.awsvpnclient;
    # })
  ];
  hardware.logitech.wireless.enable = true;
  programs.dconf.enable = true;
  networking.hostName = "yeetdesk";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = [ kvmfr ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  # virtualisation.oci-containers = {
  #   backend = "docker";
  #   containers = {
  #     traefik = {
  #       autoStart = true;
  #       image = "traefik:v2.11";
  #       ports = [ "80:80" "8080:8080" ];
  #       networks = [
  #         "dooted"
  #       ];
  #       cmd = [
  #         "--log.level=DEBUG"
  #         "--api.insecure=true"
  #         "--providers.docker=true"
  #         "--providers.docker.exposedbydefault=false"
  #         "--entrypoints.web.address=:80"
  #       ];
  #       volumes = [
  #         "/var/run/docker.sock:/var/run/docker.sock:ro"
  #       ];
  #     };
  #   };
  # };

  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = [ pkgs.spotify ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

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

