# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, inputs, ... }:

let
  hasIPv6Internet = false;
in

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
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

  # Shell aliases
  environment.shellAliases = {
    vpndown = "sudo systemctl stop wg-quick-wg0.service";
    vpnup = "sudo systemctl start wg-quick-wg0.service";
  };

  # Encrypted DNS
  networking = {
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
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

      ipv6_servers = hasIPv6Internet;
      block_ipv6 = !(hasIPv6Internet);

      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;

      server_names = [
        "quad9-dnscrypt-ip4-nofilter-pri"
        "quad9-dnscrypt-ip6-nofilter-pri"
      ];
    };
  };

  systemd.services.dnscrypt-proxy.serviceConfig.StateDirectory = "dnscrypt-proxy";

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

  # GreetD
  services.greetd.enable = true;
  services.displayManager.regreet = {
    enable = true;
    settings = {
      background = {
        path = "${pkgs.nixos-artwork.wallpapers.gear.src}";
        fit = "Cover";
      };
    };
  };

  # Enable the KDE Plasma Desktop Environment.
  #services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];

  # Enable the GNOME Desktop Environment.
  /*services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Enable XDG Desktop Portals for Wayland screen capturing
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
    config.common.default = [ "gnome" "gtk" ];
  };

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    gnome-software
  ];

  programs.dconf.enable = true;*/

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
    description = "Andrew";
    extraGroups = [
      "networkmanager"
      "wheel"
      "i2c"
      "libvirtd"
    ];
    packages = with pkgs; [
      #hi
    ];
  };

  users.users.root.hashedPassword = "$6$dPYL8UQ5XHgn6n9c$6X4kFs5BOMmoiVXRCYLLq8SCUgJBBTEGgJngMigzV/d3md8YiTGq4sGzNTkqbVqO6BQCIc78R40hTFJiB4TNV.";

  # Mount drive
  fileSystems."/mnt/external" = {
    device = "/dev/disk/by-uuid/61a25df3-1794-4859-a2de-ad5a86247f67";
    fsType = "btrfs"; # Replace with your actual filesystem type (e.g., vfat, ntfs)
    options = [
      "nofail" # Ensures the system boots even if the drive is unplugged
      "users" # Allows normal users to mount and unmount the drive
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
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # NVIDIA
  hardware.graphics = {
    enable = true;
    #enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      #mesa.drivers
    ];
  };

  boot.kernelModules = [ "nouveau" ];
  boot.blacklistedKernelModules = [ "nvidia" "nvidia_uvm" "nvidia_drm" "nvidia_modeset" ];

  #services.xserver.videoDrivers = [ "nvidia" ];
  #hardware.nvidia.open = true;

  # Flatpak
  services.flatpak.enable = true;

  # Zerotier
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "b103a835d2542825" ];
  };

  # KDE Connect
  programs.kdeconnect.enable = true;

  # QT
  /*qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };*/

  # Nvf
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        # Theme settings
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark"; # Options: "dark", "light"
        };

        # UI and aesthetics
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        treesitter.enable = true;

        # Basic editor options
        options = {
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
          number = true;
          relativenumber = true;
        };

        # Language Server Protocol (LSP) setup
        lsp = {
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
        };

        # Languages to support out-of-the-box
        languages = {
          markdown.enable = true;
          tsx.enable = true; # TypeScript/JavaScript
          rust.enable = true;
          python.enable = true;
          lua.enable = true;
        };
      };
    };
  };

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
      #SearchEngines.Default = "DuckDuckGo";
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

  # Bash
  programs.bash = {
    promptInit = ''
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
    '';
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
    flatpak
    p7zip
    unrar-free
    steam-run
    comic-neue
    mangohud
    loupe
    haruna
    kdePackages.kcalc
    nerd-fonts.droid-sans-mono
    qpwgraph
    kdePackages.partitionmanager
    ffmpeg-full
    krita
    git
    python3
    fastfetch
    qbittorrent
    yt-dlp
    btop
    tenacity
    lua
    tree
    ruby
    devenv
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
