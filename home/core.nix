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
    eza
    zsh-fzf-tab
    php
    alejandra

    # tree
    # pyenv
    # autojump
    # nodejs
    # lsd
    # tmux
    # ripgrep
  ];

  programs = {
    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.
    # eza = {
    #   enable = true;
    #   enableAliases = true;
    #   git = true;
    #   icons = true;
    # };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    lsd = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };

    tmux = {
      enable = true;
      shortcut = "a";
      secureSocket = false;

      # Remove delay when pressing escape
      escapeTime = 0;

      plugins = with pkgs; [
        tmuxPlugins.catppuccin
      ];

      extraConfig = ''
        # Colors
        set -g default-terminal "tmux-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"

        unbind C-b
        set-option -g prefix C-a
        bind-key C-a send-prefix
        set -g status-style 'bg=#333333 fg=#5eacd3'

        bind r source-file ~/.tmux.conf
        set -g base-index 1

        # split panes using | and -
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        # vim-like pane switching
        bind -r ^ last-window
        bind -r k select-pane -U
        bind -r j select-pane -D
        bind -r h select-pane -L
        bind -r l select-pane -R

        # don't rename windows automatically
        set-option -g allow-rename off

        bind c new-window -c "#{pane_current_path}"

        bind-key -r f run-shell "tmux neww ~/.local/bin/tmux-sessionizer"
      '';
    };

    /* zsh = {
      enable = true;
      enableCompletion = true;
      completionInit = "autoload -U compinit && compinit\nsource ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh";
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        #Shotcuts
        j() {
            cd "$(cat /Users/xavier/Library/autojump/autojump.txt | cut -f2 | sed 's|^/||' | fzf | sed 's|^|/|')"
        }

        # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

        # PyEnv Configuration
        # export PATH="~/.pyenv/bin:$PATH" (for linux)
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init --path)"
        eval "$(pyenv virtualenv-init -)"

        #if which pyenv-virtualenv-init > /dev/null; then 
        #eval "$(pyenv virtualenv-init -)";
        #fi

        # >>> conda initialize >>>
        # !! Contents within this block are managed by 'conda init' !!
        __conda_setup="$('/Users/xavier/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "/Users/xavier/anaconda3/etc/profile.d/conda.sh" ]; then
                . "/Users/xavier/anaconda3/etc/profile.d/conda.sh"
            else
                export PATH="/Users/xavier/anaconda3/bin:$PATH"
                    fi
                    fi
                    unset __conda_setup
        # <<< conda initialize <<<

      '';
      shellAliases = {
        # s = "kitten ssh";
        yoink = "open -a Yoink";
        vim = "nvim";
      };
      envExtra = ''
        . "$HOME/.cargo/env"
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [
          "autojump"
        ];
        theme = "agnoster";
      };
    }; */
  };
}
