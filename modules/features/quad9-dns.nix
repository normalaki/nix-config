{ self, inputs, ... }: {

  flake.nixosModules.quad9Dns = { pkgs, ... }: {
    networking = {
      nameservers = [
        "9.9.9.10#unfiltered.quad9.net"
        "149.112.112.10#unfiltered.quad9.net"
      ];

      networkmanager.dns = "systemd-resolved";
    };

    services.resolved = {
      enable = true;
      
      settings.Resolve = {
        DNSOverTLS = "true";
        DNSSEC = "true";
      };
    };
  };
}
