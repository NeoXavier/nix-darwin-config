{
  pkgs,
  inputs,
  ...
}: let
  # Nixvim
  nixvimconfig = import ./nixvim;
  nixvim = inputs.nixvim.legacyPackages.aarch64-darwin.makeNixvimWithModule {
    inherit pkgs;
    module = nixvimconfig;
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

    # nixvim
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
