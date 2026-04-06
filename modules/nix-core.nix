{
  pkgs,
  lib,
  config,
  ...
}: {
  nix.enable = false;
  # enable flakes globally
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    nix-path = config.nix.nixPath;
  };

  # Allow unfree packages (non open source)
  nixpkgs.config.allowUnfree = true;
  # Allow unsupported system (e.g. aarch64-darwin on a x86 system).
  # nixpkgs.config.allowUnsupportedSystem = true;

  # If you want nix-darwin to manage which Nix package is used, you can set it here.
  # By default, nix-darwin uses pkgs.nix.
  # Leave this unset when using Determinate Nix, because Determinate manages Nix outside nix-darwin.
  # nix.package = pkgs.nix;

  # In a standard nix-darwin-managed setup, this lets nix-darwin manage the nix-daemon service.
  # Leave this unset when using Determinate Nix, because Determinate manages the daemon/install itself.
  # services.nix-daemon.enable = true;

  # In a standard macOS Nix setup, this controls daemon-based Nix usage.
  # Leave this unset when using Determinate Nix.
  # nix.useDaemon = true;

  # do garbage collection weekly to keep disk usage low
  # nix.gc = {
  #   automatic = lib.mkDefault true;
  #   options = lib.mkDefault "--delete-older-than 7d";
  # };

  # Disable auto-optimise-store because of this issue:
  #   https://github.com/NixOS/nix/issues/7273
  # "error: cannot link '/nix/store/.tmp-link-xxxxx-xxxxx' to '/nix/store/.links/xxxx': File exists"
  # nix.settings = {
  #   auto-optimise-store = false;
  # };
}
