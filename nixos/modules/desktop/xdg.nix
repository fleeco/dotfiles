{ pkgs, ... }: {
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
}
