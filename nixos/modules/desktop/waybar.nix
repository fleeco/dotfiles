{ theme, lib, inputs, ... }: {
  programs.waybar = {
    enable = true;
    style = ''
      /* Grabs colors from catppuccin */
      ${builtins.readFile("${inputs.catppuccin-waybar}/themes/${lib.toLower theme}.css")}
 
      * {
          /* reference the color by using @color-name */
          color: @text;
        }

        window#waybar {
          /* you can also GTK3 CSS functions! */
          background-color: shade(@base, 0.9);
          border: 2px solid alpha(@crust, 0.3);
        }
    '';
  };
}
