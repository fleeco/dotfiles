{ pkgs, ... }: {

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.8;
        padding = {
          x = 10;
          y = 10;
        };
      };

      font = {
        size = 11;
        normal = {
          family = "Meslo LGS Nerdfont";
          style = "Regular";
        };
      };

    };
  };
}
