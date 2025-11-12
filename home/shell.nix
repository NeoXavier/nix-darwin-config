{ pkgs, ... }: {
  home.file = {
    ".local/bin/op-api-keys" = {
      text = ''
        # API key for ChatGPT
        export OPENAI_API_KEY="$(op read "op://private/ChatGPT API Key/text")"
      '';
      executable = true;
    };

    ".local/bin/tmux-sessionizer" = {
      text = ''
        #!/usr/bin/env bash

        if [[ $# -eq 1 ]]; then
            selected=$1
        else
            selected=$(find ~/Uol_CS\(Local\)/modules ~/projects -mindepth 1 -maxdepth 1 -type d | fzf)
        fi

        if [[ -z $selected ]]; then
            exit 0
        fi

        selected_name=$(basename "$selected" | tr . _)
        tmux_running=$(pgrep tmux)

        # Not in tmux and no tmux session running
        # -z stands for string is length 0 (man test)
        if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
            tmux new-session -s $selected_name -c $selected
            exit 0
        fi

        # Selected name does not exist as a session
        if ! tmux has-session -t=$selected_name 2> /dev/null; then
            tmux new-session -ds $selected_name -c $selected
        fi

        # If both in a tmux session and tmux is running
        if ! [[ -z $TMUX  ]] && ! [[ -z $tmux_running ]]; then
            tmux switch-client -t $selected_name
        else
            # Not in a tmux session but tmus is running
            tmux attach -t $selected_name
        fi
      '';
      executable = true;
    };

    ".config/tmux/plugins/catppuccin/tmux" = {
      source = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "v2.1.3";
      sha256 = "sha256-Is0CQ1ZJMXIwpDjrI5MDNHJtq+R3jlNcd9NXQESUe2w=";
      };
      };

  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      completionInit = ''
        autoload -Uz compinit && compinit
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      '';
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      # Homebrew path for Apple Silicon and Intel Macs
      envExtra = ''
        export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"
        export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
        export PATH="/Library/TeX/texbin:$PATH"
      '';

      initContent = ''
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
         export PYENV_ROOT="$HOME/.pyenv"
         [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
         eval "$(pyenv init --path)"
         eval "$(pyenv init -)"
         eval "$(pyenv virtualenv-init -)"
         export PYENV_VIRTUALENV_DISABLE_PROMPT=1

         # if which pyenv-virtualenv-init > /dev/null; then
         # eval "$(pyenv virtualenv-init -)";
         # fi

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
        yoink = "open -a Yoink";
        vim = "/etc/profiles/per-user/xavier/bin/nvim";
        # vim = "/opt/homebrew/bin/nvim";
        vimrc = "nvim ~/.config/nvim";
        zshrc = "vim ~/.zshrc";
        rezsh = "exec zsh";
        dot = "/usr/bin/git --git-dir=/Users/xavier/.cfg --work-tree=/Users/xavier";
        tma = "tmux attach -t";
        tls = "tmux list-sessions";
        ts = "~/.local/bin/tmux-sessionizer";
        yz = "yazi";
        lk = "~/.local/bin/op-api-keys";
      };
    };

    tmux = {
      enable = true;
      shortcut = "a";
      secureSocket = false;

      # Remove delay when pressing escape
      escapeTime = 0;

      sensibleOnTop = false;

      extraConfig = ''
        # Colors
        set -g default-terminal "tmux-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"

        # unbind C-b
        # set-option -g prefix C-a
        # bind-key C-a send-prefix

        # Styling
        # set -g status-style 'bg=#333333 fg=#5eacd3' # blue text for default status bar
        # Configure the catppuccin plugin
        set -g @catppuccin_flavor "mocha"
        set -g @catppuccin_window_status_style "rounded"
        run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux

        # Make the status line pretty and add some modules
        set -g status-right-length 100
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_host}"

        bind r source-file ~/.config/tmux/tmux.conf
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

        set -gq allow-passthrough on
        set -g visual-activity off
      '';
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    ranger = {
      enable = true;
      settings = {
        preview_images_method = "kitty";
      };
      rifle = [
          {
            condition = "ext pdf|docx|epub|cb[rz], has zathura, X, flag f";
            command = ''${pkgs.zathura}/bin/zathura -- "$@"'';
          }
      ];
    };
  };
}
