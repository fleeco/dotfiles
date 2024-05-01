{ pkgs, lib, theme, ... }: {
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

}
