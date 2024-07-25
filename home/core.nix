{
  pkgs,
  inputs,
  ...
}: let
  # Nixvim
  nvimconfig = import ./nixvim;
  nvim = inputs.nixvim.legacyPackages.aarch64-darwin.makeNixvimWithModule {
    inherit pkgs;
    module = nvimconfig;
  };
in {
  home.packages = with pkgs; [
    # archives
    zip
    unzip

    # utils
    bat
    fx

    # misc
    which
    # gnused
    # gnutar
    # gawk
    # gnupg
    # go
    zsh-fzf-tab
    php
    alejandra

    tree
    pyenv
    autojump
    nodejs

    nvim
  ];

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    lsd.enable = true;
    ripgrep.enable = true;
  };
}
