{...}: {
  programs.alacritty = {
    enable = true;

    settings = {
      colors = {
        draw_bold_text_with_bright_colors = true;
        primary = {
          background = "#282a36";
          foreground = "#eff0eb";
        };
        cursor = {
          cursor = "#97979b";
        };
        selection = {
          text = "#282a36";
          background = "#feffff";
        };
        normal = {
          black = "#282a36";
          red = "#ff5c57";
          green = "#5af78e";
          yellow = "#f3f99d";
          blue = "#57c7ff";
          magenta = "#ff6ac1";
          cyan = "#9aedfe";
          white = "#f1f1f0";
        };
        bright = {
          black = "#686868";
          red = "#ff5c57";
          green = "#5af78e";
          yellow = "#f3f99d";
          blue = "#57c7ff";
          magenta = "#ff6ac1";
          cyan = "#9aedfe";
          white = "#eff0eb";
        };
      };
      env = {
        TERM = "xterm-256color";
      };
      font = {
        size = 14;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
      };
      window = {
        opacity = 0.85;
        title = "Alacritty";
      };
    };
  };
}
