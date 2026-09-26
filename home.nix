{ config, pkgs, inputs, ... }:

{

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

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

  /*programs.wofi = {
    enable = true;
    settings = {
      width = 400;
      height = 300;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_title = true;
    };
  };*/
  
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "chk_it";
	      email = "ezman2915@gmail.com";
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
    name = "breeze-cursors";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze; 
    };
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-icons;
    };
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

  # Files
  home.file.".config/niri/config.kdl".source = ./niri.kdl;

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
