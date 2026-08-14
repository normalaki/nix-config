{ self, inputs, ... }: {
  
  flake.nixosModules.customSddm = { pkgs, ... }: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "Elegant";
      extraPackages = [
        (pkgs.elegant-sddm.override {
          themeConfig.General.background = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray}";
        })
      ];
    };

    environment.systemPackages = [
      (pkgs.elegant-sddm.override {
        themeConfig.General.background = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray}";
      })
    ];
  };
}
