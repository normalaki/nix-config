{ self, inputs, ... }: {
  
  flake.homeManager.swayCustom = { pkgs, config, lib, ...}: {
    wayland.windowManager.sway = {
      enable = true;
      config = rec {
        modifier = "Mod4";
        terminal = "foot";

        bars = lib.mkForce [ ];
        window.titlebar = false;
        floating.titlebar = false;

        startup = [
          { command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"; always = true; }
        ];

        output = {
          "*" = {
            bg = "${pkgs.nixos-artwork.wallpapers.gear.gnomeFilePath} fill"; 
          };
        };

        workspaceOutputAssign = [
          {
            workspace = "1";
            output = "eDP-1";
          }
        ];

        input = {
          "type:keyboard" = {
            xkb_layout = "us,ua";
            xkb_options = "gtp:alt_shift_toggle";
          };
        };

        keybindings = let
          mod = "Mod4";
        in lib.mkOptionDefault {
          #"${mod}+d" = "exec ${pkgs.fuzzel}/bin/fuzzel";

          # Audio
          "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

          "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

          "${mod}+Shift+f" = "exec thunar";
          "Print" = "exec env QT_QPA_PLATFORM=xcb flameshot gui";
          "${mod}+l" = "exec swaylock --color 000000";
        };
      };
    };
  };
}
