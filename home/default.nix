{
  lib,
  inputs,
  ...
}: let
  user = "xavier";
in {
  # import sub modules
  imports = [
    ./core.nix
    ./git.nix
    ./alacritty.nix
    ./kitty.nix
    ./shell.nix
    ./nvim.nix
    ./starship.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "${user}";
    homeDirectory = lib.mkForce "/Users/${user}";
    stateVersion = "23.11";

    # Rawdog config files (for packages with no Home Manager support)
    file.".config/aerospace/aerospace.toml".source = ../config/aerospace/aerospace.toml;
    file.".config/ghostty/config".source = ../config/ghostty/config;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  manual.manpages.enable = false;

  # Fully declarative dock using the latest from Nix Store
}
