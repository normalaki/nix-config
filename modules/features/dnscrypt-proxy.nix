{ self, inputs, ... }: {
  
  flake.nixosModules.dnsCryptProxy = { config, pkgs, ... }: {
    networking = {
      nameservers = [ "127.0.0.1" "::1" ];
      networkmanager.dns = "none";
    };
    services.resolved.enable = false;

    services.dnscrypt-proxy = {
      enable = true;
      settings = {
        sources.public-resolvers = {
          urls = [
      "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
      "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
    ];
    minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
    cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
        };

        ipv6_servers = true;
        block_ipv6 = true;

        require_dnssec = true;
        require_nolog = true;
        require_nofilter = true;

        server_names = [ "quad9-dnscrypt-ip4-nofilter-pri" "quad9-dnscrypt-ip6-nofilter-pri" ];
      };
    };

    systemd.services.dnscrypt-proxy.serviceConfig.StateDirectory = "dnscrypt-proxy";

  };

}
