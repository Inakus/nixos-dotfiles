{ config, pkgs, ... }:

{
    programs.hyprland = {
        enable = true;
    };

    environment.systemPackages = with pkgs; [
      hyprpaper
      kitty
      libnotify
      mako
      qt5.qtwayland
      qt6.qtwayland
      wlogout
      wl-clipboard
      rofi-wayland
      wofi
      swayidle
      swaylock-effects
      waybar
      hyprcursor
    ];

    environment.sessionVariables = {
  #If your cursor becomes invisible
  WLR_NO_HARDWARE_CURSORS = "1";
  #Hint electron apps to use wayland
  NIXOS_OZONE_WL = "1";
  GBM_BACKEND = "nvidia-drm";
  __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

environment.variables = {
  XCURSOR_THEME = "Catppuccin-Macchiato-Blue";
  XCURSOR_SIZE = "24"; # lub inny rozmiar, jaki preferujesz
};
}
