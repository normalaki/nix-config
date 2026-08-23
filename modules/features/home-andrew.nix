{ self, inputs, ... }: {
  flake.homeModules.andrewProfile = { config, pkgs, inputs, lib, ... }: {
    imports = [
      self.homeManager.swayCustom
    ];
    
    home.username = "andrew";
    home.homeDirectory = "/home/andrew";

    # Plasma customization
    /*programs.plasma = {
      enable = true;
      workspace.wallpaper = "${pkgs.nixos-artwork.wallpapers.gear.kdeFilePath}";

      kscreenlocker.appearance.wallpaper = "${pkgs.nixos-artwork.wallpapers.gear.kdeFilePath}";

      powerdevil = {
        AC = {
          autoSuspend = {
            action = "nothing";
            idleTimeout = null;
          };

          dimDisplay = {
            enable = true;
            idleTimeout = 300;
          };

          turnOffDisplay = {
            idleTimeout = 600;
            idleTimeoutWhenLocked = 60;
          };

          powerButtonAction = "showLogoutScreen";

          whenLaptopLidClosed = "turnOffScreen";

          inhibitLidActionWhenExternalMonitorConnected = false;

        };
      };
    };*/

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      #autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      # Configure Oh My Zsh
      oh-my-zsh = {
        enable = true;
        theme = "avit";
      };
    };

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-pipewire-audio-capture
      ];
    };

    programs.hyfetch = {
      enable = true;
      settings = {
        color_align.mode = "horizontal";
        mode = "rgb";
        preset = "transgender";
        backend = "fastfetch";
        pride_month_disable = true;
      };
    };

    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "chk_it";
    email = "a@a.com";
        };
        credential.helper = [
          "store"
        ];
      };
    };

    # Pointer cursor
    home.pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    # Packages that should be installed to the user profile.
    home.packages = [
      pkgs.fortune
      pkgs.cowsay
      pkgs.love
      pkgs.figlet
      pkgs.blender
      pkgs.heroic
      pkgs.vesktop
      pkgs.prismlauncher
    ];

    home.stateVersion = "26.11";

    programs.home-manager.enable = true;

    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
}
