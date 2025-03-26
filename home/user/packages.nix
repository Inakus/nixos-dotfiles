{ pkgs, pkgs-unstable, system, inputs, ... }:

{
  

  home.packages = [

    # Dev stuff
    pkgs.jetbrains.rider
    pkgs.dotnet-sdk_8
    pkgs.dotnetPackages.Nuget
    pkgs.gcc
    pkgs.go
    pkgs.lua
    pkgs.nodejs_23
    pkgs.nodePackages.pnpm
    (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.pip
        python-pkgs.requests
    ]))
    pkgs.pkgsCross.mingwW64.stdenv.cc 
    pkgs.pkgsCross.mingwW64.windows.pthreads
    
    # Work stuff
    pkgs.obsidian
    pkgs.teams-for-linux
    pkgs.thunderbird
    pkgs.libreoffice-qt
 
    # Social
    pkgs.vesktop
    pkgs.spotify
    inputs.zen-browser.packages."${system}".default

    # Gaming
    pkgs.steam
    pkgs.steam-run
    pkgs.heroic
    pkgs.bottles
    pkgs.protonup
    #pkgs.wineWowPackages.stable
    #pkgs.wine
    #(pkgs.wine.override { wineBuild = "wine64"; })
    #pkgs.wine64
    #pkgs.wineWowPackages.staging
    #pkgs.winetricks
    #pkgs.wineWowPackages.waylandFull
    pkgs.lutris

    # Downloads
    pkgs.qbittorrent

    # Utils
    pkgs.viewnior
    pkgs.hyprshot
    pkgs.catppuccin-cursors.macchiatoBlue
    pkgs.catppuccin-gtk
    pkgs.papirus-folders
  ];
}
