{ pkgs
, config
, lib
, ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = true;
    extraPackages = with pkgs; [
      shfmt
      ripgrep
      unzip

      # Used for treesitter
      gcc
      tree-sitter

      lua-language-server
      stylua
      selene

      python311Packages.python-lsp-server

      nodePackages.typescript-language-server

      nil
      alejandra
      wl-clipboard

      imagemagick
    ];
    extraLuaPackages = ps: with ps; [
      magick # for image rendering
    ];
    # extraPython3Packages = ps: with ps; [
    #   pynvim
    #   jupyter-client
    #   cairosvg # for image rendering
    #   pnglatex # for image rendering
    #   plotly # for image rendering
    #   pyperclip
    # ];
  };

# Copy neovim config to config path (uncomment when config is ready to use)
  # xdg.configFile."nvim" = {
  #   source = ../config/nvim;
  #   recursive = true;
  # };

  home.packages = with pkgs; [
    (writeShellScriptBin "clean-nvim" ''
      rm -rf ${config.xdg.dataHome}/nvim
      rm -rf ${config.xdg.stateHome}/nvim
      rm -rf ${config.xdg.cacheHome}/nvim
    '')
    (writeShellScriptBin "clean-nvim-full" ''
      rm -rf ${config.xdg.dataHome}/nvim
      rm -rf ${config.xdg.stateHome}/nvim
      rm -rf ${config.xdg.cacheHome}/nvim
      rm -rf ${config.xdg.configHome}/nvim
    '')


  ];
}
