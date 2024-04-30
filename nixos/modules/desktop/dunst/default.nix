{ pkgs, ... }: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "0x30";
        origin = "top-center";
        transparency = 10;
        frame_color = "#eceff1";
        follow = "keyboard";
      };
    };
  };
}
