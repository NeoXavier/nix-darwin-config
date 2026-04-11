{ pkgs, ... }: {
  # home.file = {
  #   ".local/bin/op-api-keys" = {
  #     text = ''
  #       # API key for ChatGPT
  #       export OPENAI_API_KEY="$(op read "op://private/ChatGPT API Key/text")"
  #     '';
  #     executable = true;
  #   };

  home.file = {
    ".local/bin/tmux-sessionizer" = {
      text = ''
        #!/usr/bin/env bash

        if [[ $# -eq 1 ]]; then
            selected=$1
        else
            selected=$(find ~/dev -mindepth 1 -maxdepth 1 -type d | fzf)
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

    ".local/bin/agentic-workspace-tmux" = {
      source = pkgs.writeShellScript "agentic-workspace-tmux" ''
        #!/usr/bin/env bash

        set -euo pipefail

        SESSION_NAME="agentic"

        WINDOWS=(agentic-soc agentic-soc-infra triage-agent job-enhancement-backend job-enhancement-frontend embedding-service)

        DIRS=(
          "$HOME/dev/agentic/agentic_soc"
          "$HOME/dev/agentic/agentic_soc_infra"
          "$HOME/dev/agentic/triage_agent"
          "$HOME/dev/agentic/job-enhancement-backend"
          "$HOME/dev/agentic/job-enhancement-frontend"
          "$HOME/dev/agentic/embedding_service"
        )

        if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
          exec tmux attach -t "$SESSION_NAME"
        fi

        tmux new-session -d -s "$SESSION_NAME" -n "''${WINDOWS[0]}" -c "''${DIRS[0]}"

        for i in "''${!WINDOWS[@]}"; do
          if [ "$i" -eq 0 ]; then
            continue
          fi

          tmux new-window -t "$SESSION_NAME:$((i+1))" -n "''${WINDOWS[$i]}" -c "''${DIRS[$i]}"
        done

        # for i in "''${!WINDOWS[@]}"; do
        #   if [ -n "''${CMDS[$i]}" ]; then
        #     tmux send-keys -t "$SESSION_NAME:''${WINDOWS[$i]}" "''${CMDS[$i]}" C-m
        #   fi
        # done

        tmux select-window -t "$SESSION_NAME":1
        exec tmux attach -t "$SESSION_NAME"
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
        export PATH="$PATH:/opt/homebrew/bin"
      '';

      initContent = ''
         #autojump
         .  ${pkgs.autojump}/share/autojump/autojump.zsh

         #Shotcuts
         j() {
            cd "$(cat /Users/xavier_neo/Library/autojump/autojump.txt | cut -f2 | sed 's|^/||' | fzf | sed 's|^|/|')"
        }


         # Starship
        eval "$(starship init zsh)"
      '';

      shellAliases = {
        yoink = "open -a Yoink";
        # vim = "/etc/profiles/per-user/xavier/bin/nvim";
        # vim = "/opt/homebrew/bin/nvim";
        vimrc = "nvim ~/.config/nvim";
        zshrc = "vim ~/.zshrc";
        rezsh = "exec zsh";
        tma = "tmux attach -t";
        tls = "tmux list-sessions";
        ts = "~/.local/bin/tmux-sessionizer";
        agentic = "~/.local/bin/agentic-workspace-tmux";
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

        # Turn off automatic window renaming from tmux (e.g.) when you run vim, it changes the window name to the file you're editing
        #and set the window title to the current command
        set -g automatic-rename off
        set -g @catppuccin_window_text "#W"
        set -g @catppuccin_window_current_text "#W"

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

        # don't rename windows automatically from apps
        set-option -g allow-rename off

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
  };
}
