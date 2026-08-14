{ self, inputs, ... }: {
  flake.nixosConfigurations.tufnix = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.tufnixConfiguration
    ];
  };
}
