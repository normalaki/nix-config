{ self, inputs, ... }: {
  
  flake.nixosModules.sway = { pkgs, config, ... }: {
    
    environment.systemPackages = with pkgs; [
      wl-clipboard
      mako
      xwayland-satellite
      lxqt.lxqt-policykit
      fuzzel
      slurp
      swaylock
      swayimg
      thunar
      adwaita-icon-theme
      flameshot
      emote
      loupe
      gnome-calculator
    ];

    services.gnome.gnome-keyring.enable = true;

    xdg.mime = {
      enable = true;
      defaultApplications = {
        "audio/mpeg" = "mpv.desktop";
        "audio/ogg" = "mpv.desktop";
        "audio/wav" = "mpv.desktop";
        "audio/x-wav" = "mpv.desktop";
        "audio/flac" = "mpv.desktop";
        "video/mp4" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
      };
    };

    systemd.user.services.lxqt-policykit-agent = {
      description = "LXQt PolicyKit Authentication Agent";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent";
        Restart = "on-failure";
        RestartSec = 1;
      };
    };


    programs.waybar.enable = true;

    services.logind = {
      settings.Login = {
        HandlePowerKey = "ignore";
        HandlePowerKeyLongPress = "ignore";
      };
    };
    
    services.upower.enable = true;

    services.power-profiles-daemon.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      wlr.settings.screencast = {
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
      };
      config.sway = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      };
    };

    security.polkit.enable = true;

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

  };
}
