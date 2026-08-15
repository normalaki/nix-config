{ self, inputs, ... }: {
  
  flake.nixosModules.homeManager = { config, pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs; };
      users.andrew = self.homeModules.andrewProfile;
      backupFileExtension = "bak";
    };

  };
}
