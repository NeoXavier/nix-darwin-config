{ inputs, home-manager, darwin }:

{ system, user }:
darwin.lib.darwinSystem {
  inherit system;
  modules = [
    ../modules/nix-core.nix
    ../modules/apps.nix
    ../modules/system.nix
    # home manager
    home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      home-manager.extraSpecialArgs = { inherit inputs; };
      home-manager.users.${user} = import ../home;
    }
    # We expose some extra arguments so that our modules can parameterize
    # better based on these values.
    {
      config._module.args = {
        currentSystem = system;
        currentSystemUser = user;
        inputs = inputs;
      };
    }
  ];
}
