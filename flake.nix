{
  description = "Nix for macOS configuration";

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , darwin
    , home-manager
    , ...
    }: {
      darwinConfigurations =
        let
          user = "xavier";
        in
        {
          "Xaviers-MacBook-Pro" = darwin.lib.darwinSystem {
            system = "aarch64-darwin"; # change this to "aarch64-darwin" if you are using Apple Silicon
            modules = [
              ./modules/nix-core.nix
              ./modules/apps.nix
              # ./modules/system.nix
              # ./modules/dock.nix

              # home manager
              home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = inputs;
                home-manager.users.${user} = import ./home;
              }
            ];
          };
        };
      # nix code formatter
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    };
}
