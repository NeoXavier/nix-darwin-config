{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    theme = "Snazzy";
    keybindings = {
      "super+f" = "launch --type=overlay --stdin-source=@screen_scrollback /bin/sh -c '${pkgs.fzf}'/bin/fzf --no-sort --no-mouse --exact -i --tac | kitty +kitten clipboard";
      "super+." = "set_tab_title";
      "super+c" = "copy_to_clipboard";
      "super+v" = "paste_from_clipboard";
    };
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = "14.0";
      scrollback_lines = 4000;
      scrollback_pager_history_size = 256;
      macos_quit_when_last_window_closed = true;
      confirm_os_window_close = "0";
      background_opacity = "0.85";
      cursor_shape = "block";
      macos_show_window_title_in = "none";
    };
    shellIntegration.enableZshIntegration = true;
    shellIntegration.mode = "no-cursor";
  };
}
