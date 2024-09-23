{pkgs, ...}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      completionInit = "autoload -U compinit && compinit\nsource ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh";
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      /* plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ]; */

      /* initExtraFirst = ''
        if [[ -r "$\{XDG_CACHE_HOME:-\$HOME/.cache\}/p10k-instant-prompt-$\{(%):-%n}.zsh" ]]; then
            source "$\{XDG_CACHE_HOME:-\$HOME/.cache\}/p10k-instant-prompt-$\{(%):-%n}.zsh"
                fi
      ''; */

      initExtra = ''
        #autojump
        .  ${pkgs.autojump}/share/autojump/autojump.zsh

        #Shotcuts
        j() {
            cd "$(cat /Users/xavier/Library/autojump/autojump.txt | cut -f2 | sed 's|^/||' | fzf | sed 's|^|/|')"
        }

        # Starship
        eval "$(starship init zsh)"


        # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
        #[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

        # PyEnv Configuration
        # export PATH="~/.pyenv/bin:$PATH" (for linux)
        # export PYENV_ROOT="$HOME/.pyenv"
        # export PATH="$PYENV_ROOT/bin:$PATH"
        # eval "$(pyenv init --path)"
        # eval "$(pyenv virtualenv-init -)"

        #if which pyenv-virtualenv-init > /dev/null; then
        #eval "$(pyenv virtualenv-init -)";
        #fi

        # >>> conda initialize >>>
        # !! Contents within this block are managed by 'conda init' !!
        # __conda_setup="$('/Users/xavier/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        # if [ $? -eq 0 ]; then
        # eval "$__conda_setup"
        # else
        # if [ -f "/Users/xavier/anaconda3/etc/profile.d/conda.sh" ]; then
        # . "/Users/xavier/anaconda3/etc/profile.d/conda.sh"
        # else
        # export PATH="/Users/xavier/anaconda3/bin:$PATH"
        # fi
        # fi
        # unset __conda_setup
        # <<< conda initialize <<<
      '';

      shellAliases = {
        yoink = "open -a Yoink";
        # vim = "/etc/profiles/per-user/xavier/bin/nvim";
        vim = "/usr/local/bin/nvim";
        vimrc = "nvim ~/.config/nvim";
        zshrc = "vim ~/.zshrc";
        rezsh = "exec zsh";
        dot = "/usr/bin/git --git-dir=/Users/xavier/.cfg --work-tree=/Users/xavier";
        ls = "lsd";
        tma = "tmux attach -t";
        tls = "tmux list-sessions";
        ts = "~/.local/bin/tmux-sessionizer";
        yz = "yazi";
      };
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

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    yazi.enable = true;
  };
}
