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

  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    ".config/nvim/lua" = {
      source = ./config/lua;
      recursive = true;
    };

    ".config/nvim/after" = {
      source = ./config/after;
      recursive = true;
    };
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
}
