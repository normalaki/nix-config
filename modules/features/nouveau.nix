{ self, inputs, ... }: {
  
  flake.nixosModules.nouveau = { config, pkgs, ... }: {
    hardware.graphics = {
      enable = true;
      extraPackages = [ pkgs.mesa ];
    };

    boot.kernelModules = [ "nouveau" ];
    boot.blacklistedKernelModules = [
      "nvidia"
      "nvidia_uvm"
      "nvidia_drm"
      "nvidia_modeset"
    ];
  };
}
