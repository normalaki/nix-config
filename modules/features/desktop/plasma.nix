{ self, inputs, ... }: {

  flake.nixosModules.plasma = { pkgs, config, lib, ... }: {
    services.desktopManager.plasma6.enable = true;

    environment.plasma5.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
    ];
  };
}
