{
  description = "Nix for macOS configuration";

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , darwin
    , home-manager
    , ...
    }:
    let
      mkSystem = import ./lib/mkSystem.nix {
        inherit inputs home-manager darwin;
      };
    in
    {
      darwinConfigurations.xavier-aarch64 = mkSystem {
        system = "aarch64-darwin";
        user = "xavier";
      };
      darwinConfigurations.xavier-x86 = mkSystem {
        system = "x86_64-darwin";
        user = "xavier";
      };
      # nix code formatter
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
      formatter.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.alejandra;
    };
}
