{ lib, inputs, ... }:
let
  user = "xavier";
in
{
  # import sub modules
  imports = [
    # inputs.nixvim.homeManagerModules.nixvim
    ./core.nix
    ./git.nix
    ./alacritty.nix
    ./shell.nix
  ]
  ;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "${user}";
    homeDirectory = lib.mkForce "/Users/${user}";
    stateVersion = "23.11";

    file.yabai = {
      executable = true;
      target = ".config/yabai/yabairc";
      text = ''
          #!/usr/bin/env sh
  
          # global settings
        yabai -m config layout bsp

        yabai -m config window_placement second_child

        # padding
        yabai -m config top_padding 5
        yabai -m config bottom_padding 5
        yabai -m config left_padding 5
        yabai -m config right_padding 5
        yabai -m config window_gap 5

        # mouse settings
        # yabai -m config mouse_follows_focus on

        # disable tiling for specific apps
        yabai -m rule --add app="^System Settings$" manage=off
        yabai -m rule --add app="^Calculator$" manage=off
        yabai -m rule --add app="^Telegram$" manage=off
        yabai -m rule --add app="^Spotify$" manage=off
        yabai -m rule --add app="^OtoDecks$" manage=off
        yabai -m rule --add app="^Find My$" manage=off
        yabai -m rule --add app="^Finder$" manage=off
        yabai -m rule --add app="^Alfred Preferences$" manage=off
        yabai -m rule --add app="^Fantastical$" manage=off
        yabai -m rule --add app="^Preview$" manage=off
        yabai -m rule --add app="^Outlook$" manage=off
        yabai -m rule --add app="^Karabiner-Elements$" manage=off
        yabai -m rule --add app="^Whatsapp$" manage=off
        yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
        yabai -m rule --add label="Finder" app="^Finder$" manage=off
        yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
        yabai -m rule --add app="^Discord$" manage=off
        # yabai -m rule --add app="^$" manage=off

        # Float non resizable windows
        # yabai -m signal --add event=window_created action='
        #   yabai -m query --windows --window $YABAI_WINDOW_ID | jq -er ".\"can-resize\" or .\"is-floating\"" || \
        #   yabai -m window $YABAI_WINDOW_ID --toggle float && \
        #   yabai -m window $YABAI_WINDOW_ID --layer above && \
        #   yabai -m window $YABAI_WINDOW_ID --grid 3:3:1:1:1:1
        # '

        echo "yabai configuration loaded"
      '';
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  manual.manpages.enable = false;

  # Fully declarative dock using the latest from Nix Store
}
