{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim" = {
    source = ../config/nvim;
    recursive = true;
  };

  programs.neovim.extraPackages = with pkgs; [
    shfmt
    ripgrep
    unzip

    # Used for treesitter
    gcc

    lua-language-server
    stylua
    selene

    python311Packages.python-lsp-server

    nodePackages.typescript-language-server

    nil
    alejandra
    wl-clipboard
  ];

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
