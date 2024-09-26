{
  lib,
  inputs,
  ...
}: let
  user = "xavier";
in {
  # import sub modules
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./core.nix
    ./git.nix
    ./alacritty.nix
    ./shell.nix
    # ./nvim.nix
    ./starship.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "${user}";
    homeDirectory = lib.mkForce "/Users/${user}";
    stateVersion = "23.11";

    file.".config/aerospace/aerospace.toml".source = ../config/aerospace/aerospace.toml;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  manual.manpages.enable = false;

  # Fully declarative dock using the latest from Nix Store
}
