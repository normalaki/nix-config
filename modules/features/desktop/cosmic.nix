{ self, inputs, ... }: {
  
  flake.nixosModules.cosmic = { pkgs, config, lib, ... }: {
    services.desktopManager.cosmic.enable = true;

    environment.cosmic.excludePackages = with pkgs; [
      cosmic-term
      cosmic-store
    ];
  };
}
