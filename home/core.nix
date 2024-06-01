{ pkgs, ... }: {
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
