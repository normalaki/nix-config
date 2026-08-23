{ self, inputs, ... }: {
  
  flake.nixosModules.desktopPrograms = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      #haruna
      mpv
      qpwgraph
      ffmpeg-full
      mangohud
      gparted
      btop
      krita
      yt-dlp
      kdePackages.kdenlive
      fastfetch
      qbittorrent
      git
      lua
      python3
      kdePackages.k3b
      tenacity
      p7zip
      curl
      wget
      vim
      steam-run
      unrar-free
    ];
    services.gvfs.enable = true;
    services.tumbler.enable = true;
  };
}
