{
  pkgs,
  lib,
  config,
  ...
}: {
  # enable flakes globally
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    nix-path = config.nix.nixPath;
  };

  # Allow unfree packages (non open source)
  nixpkgs.config.allowUnfree = true;
  # Allow unsupported system (e.g. aarch64-darwin on a x86 system).
  nixpkgs.config.allowUnsupportedSystem = true;

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true; # nix-darwin now manages nix-daemon unconditionally
  # Use this instead of services.nix-daemon.enable if you
  # don't wan't the daemon service to be managed for you.
  # nix.useDaemon = true;

  # If you want to explicitely declare the nix package to be used, you can do it here. By default, nix-darwin will use the latest version of nix from nixpkgs.
  # Remove if you are using determinate Nix as that is managed outside of the config.
  # nix.package = pkgs.nix;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Disable auto-optimise-store because of this issue:
  #   https://github.com/NixOS/nix/issues/7273
  # "error: cannot link '/nix/store/.tmp-link-xxxxx-xxxxx' to '/nix/store/.links/xxxx': File exists"
  nix.settings = {
    auto-optimise-store = false;
  };
}
