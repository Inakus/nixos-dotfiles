{ config, pkgs, pkgs-unstable, lib, inputs, ...}:

{

  imports = [
    ./user
    inputs.nixvim.homeManagerModules.nixvim

  ];

  home.username = "karold";
  home.homeDirectory = "/home/karold";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

}
