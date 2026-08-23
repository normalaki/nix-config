{ self, inputs, ... }: {

  flake.nixosModules.plasma = { pkgs, config, lib, ... }: {
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.kcalc
      haruna
      kdePackages.kamoso
    ];

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
    ];
  };
}
