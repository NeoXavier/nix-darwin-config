{ pkgs
, inputs
, ...
}:
{
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
    go
    gnupg
    zsh-fzf-tab
    php
    alejandra

    tree
    autojump
    nodejs
    lazygit

    # nixvim

    # node packages
    nodePackages.live-server
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
