{ self, inputs, ... }: {

  flake.nixosModules.cloudflareDns = { pkgs, ... }: {
    networking = {
      nameservers = [
        "1.1.1.1#cloudflare-dns.com"
        "1.0.0.1#cloudflare-dns.com"
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
