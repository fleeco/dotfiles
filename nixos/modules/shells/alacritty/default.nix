{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      window = {
        opacity = 1;
        padding = {
          x = 10;
          y = 10;
        };
      };

      font = {
        size = 12;
        normal = {
          family = "Meslo LGS Nerdfont";
          style = "Regular";
        };
      };
    };
  };
}
