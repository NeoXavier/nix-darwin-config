{
  description = "Nix for macOS configuration";

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    /* ghostty = {
      url = "github:ghostty-org/ghostty";
    }; */
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
