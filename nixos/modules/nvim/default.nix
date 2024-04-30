{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      catppuccin-nvim
      nvim-treesitter.withAllGrammars
      undotree
      vim-fugitive
      lsp-zero-nvim
    ];
    extraLuaConfig = ''
      require("dooted")
    '';
  };

  # This lets me add the rest of the lua configs
  # easily
  home.file = {
    ".config/nvim/lua" = {
      source = ./config/lua;
      recursive = true;
    };

    ".config/nvim/after" = {
      source = ./config/after;
      recursive = true;
    };
  };
}
