{ pkgs, config, ... }:
{

  # home.pointerCursor = {
  #   package = pkgs.catppuccin-cursors.mochaPink;
  #   name = "Catppuccin-Mocha-Pink-Cursors";
  #   size = 40;
  #   gtk.enable = true;
  # };

  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #   };
  # };

  # gtk = {
  #   enable = true;
  #   font = {
  #     package = (pkgs.nerdfonts.override { fonts = [ "Mononoki" ]; });
  #     name = "Mononoki Nerd Font Regular";
  #     size = 10;
  #   };

  #   theme = {
  #     name = "Catppuccin-Macchiato-Compact-Pink-Dark";
  #     package = pkgs.catppuccin-gtk.override {
  #       accents = [ "pink" ];
  #       size = "compact";
  #       tweaks = [ "rimless" "black" ];
  #       variant = "macchiato";
  #     };
  #   };

  #   iconTheme = {
  #     package = (pkgs.catppuccin-papirus-folders.override { flavor = "mocha"; accent = "pink"; });
  #     name = "Papirus-Dark";
  #   };

  #   cursorTheme = {
  #     name = "Catppuccin-Mocha-Pink";
  #     package = pkgs.catppuccin-cursors.mochaPink;
  #   };

  #   gtk3.extraConfig = {
  #     Settings = ''
  #       gtk-application-prefer-dark-theme=1
  #     '';
  #   };

  #   gtk4.extraConfig = {
  #     Settings = ''
  #               gtk-application-prefer-dark-theme=1
  #       	gtk-cursor-theme-name=Catppuccing-Mocha-Pink
  #     '';
  #   };
  # };
  # home.sessionVariables.GTK_THEME = "Gruvbox-Dark";

  # xdg.configFile = {
  #   "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  #   "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  #   "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  # };
}
