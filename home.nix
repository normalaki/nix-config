{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

  # Plasma customization
  programs.plasma = {
    enable = true;
    workspace = {
      wallpaper = "${pkgs.nixos-artwork.wallpapers.gear.kdeFilePath}";
    };
    kwin = {
      effects = {
        blur.enable = false;
      };
    };
    shortcuts = {
      "org.kde.konsole.desktop"."_launch" = "";
      "foot.desktop"."_launch" = "Ctrl+Alt+T";
    };
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

  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;

      name = "Default";

      #extraConfig = builtins.readFile ./misc/arkenfox.js;
      
      /*settings = {
        "browser.startup.blankWindow" = true;
      	"signon.rememberSignons" = false;
      	"privacy.resistFingerprinting" = true;
      	"privacy.block_mozAddonManager" = true;
      };*/
    };
  };

  /*programs.foot = {
    enable = true;
    settings.main.font = "monospace:size=12";
    #settings.main.initial-window-size-chars = "128x46";
  };*/

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.kdePackages.breeze;
    name = "breeze_cursors";
    size = 24;
  };

  /*dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "Adwaita-dark";
      };
    };
  };*/

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    fortune
    cowsay
    kdePackages.kdenlive
    love
    figlet
    blender
    heroic
    kdePackages.k3b
    linuxwave
    vesktop
    drawy
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
