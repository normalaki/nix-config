{ self, inputs, ... }: {
  
  flake.nixosModules.nixosConfiguration = { pkgs, lib, config, inputs, ... }: {
    imports =
      [
        self.nixosModules.nixosHardware
        self.nixosModules.nixvim
        self.nixosModules.homeManager
        self.nixosModules.nouveau
        self.nixosModules.cloudflareDns
        self.nixosModules.cosmic
      ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.tmp.cleanOnBoot = true;

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Wireguard
    /*networking.wg-quick.interfaces.wg0 = {
      address = [
        "172.16.0.2/32"
        "2606:4700:110:8a2a:3c20:414a:72f2:87b5/128"
      ];
      dns = [ "127.0.0.1" ];
      mtu = 1280;
      privateKey = "yBZUIwU/j4bPfwRBIBbwszWESnFpOH450PqSQbLyV1A=";

      peers = [
        {
          publicKey = "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "engage.cloudflareclient.com:2408";
        }
      ];
    };*/

    # Set your time zone.
    time.timeZone = "Europe/Kyiv";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "uk_UA.UTF-8";
      LC_IDENTIFICATION = "uk_UA.UTF-8";
      LC_MEASUREMENT = "uk_UA.UTF-8";
      LC_MONETARY = "uk_UA.UTF-8";
      LC_NAME = "uk_UA.UTF-8";
      LC_NUMERIC = "uk_UA.UTF-8";
      LC_PAPER = "uk_UA.UTF-8";
      LC_TELEPHONE = "uk_UA.UTF-8";
      LC_TIME = "uk_UA.UTF-8";
    };

    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    #services.xserver.enable = true;
    
    # Ly DM
    services.displayManager.ly.enable = true;

    # Qt
    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."andrew" = {
      isNormalUser = true;
      hashedPassword = "$6$dPYL8UQ5XHgn6n9c$6X4kFs5BOMmoiVXRCYLLq8SCUgJBBTEGgJngMigzV/d3md8YiTGq4sGzNTkqbVqO6BQCIc78R40hTFJiB4TNV.";
      shell = pkgs.zsh;
      description = "Andrew";
      extraGroups = [ "networkmanager" "wheel" "i2c" "libvirtd" ];
      packages = with pkgs; [
        #hi
      ];
    };

    users.users.root.hashedPassword = "$6$dPYL8UQ5XHgn6n9c$6X4kFs5BOMmoiVXRCYLLq8SCUgJBBTEGgJngMigzV/d3md8YiTGq4sGzNTkqbVqO6BQCIc78R40hTFJiB4TNV.";

    # Mount drive
    fileSystems."/mnt/external" = {
      device = "/dev/disk/by-uuid/61a25df3-1794-4859-a2de-ad5a86247f67";
      fsType = "btrfs"; 
      options = [
        "nofail" 
        "users" 
        "rw"
        "exec"
      ];
    };

    # Clean up old gens
    nix.gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Flatpak
    services.flatpak.enable = true;

    # Zerotier
    /*services.zerotierone = {
      enable = true;
      joinNetworks = [ "b103a835d2542825" ];
    };*/

    # Install zsh
    programs.zsh.enable = true;

    # KDE Connect
    programs.kdeconnect.enable = true;

    # Ollama
    services.ollama = {
      enable = true;
      package = pkgs.ollama-vulkan;
    };

    # Install openrgb.
    services.hardware.openrgb = {
      enable = true;
      motherboard = "amd";
    };

    hardware.i2c.enable = true;

    # Install firefox.
    programs.firefox = {
      enable = true;
      languagePacks = [ "en-US" ];
      policies = {
        DisableTelemetry = true;
        DisablePocket = true;
        SearchEngines.Default = "DuckDuckGo";
        SearchEngines.PreventInstalls = true;
      };
    };

    # Foot
    programs.foot = {
      enable = true;
      settings.main.font = "DroidSansM Nerd Font Mono:size=12";
      settings.main.initial-window-size-chars = "120x40";
      settings.colors-dark.background = "1b1e20";
    };

    # Virtualisation.
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    # Install steam.
    programs.steam.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
     vim 
     wget
     curl
     p7zip
     unrar-free
     steam-run
     comic-neue
     mangohud
     loupe
     nerd-fonts.droid-sans-mono
     qpwgraph
     kdePackages.partitionmanager
     python3
     emote
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    networking.firewall.enable = true;

    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    system.stateVersion = "26.05"; 
  };
}
