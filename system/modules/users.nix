{ config, pkgs, ... }:

{
users.users.karold = {
    isNormalUser = true;
    description = "Karol Dobrek";
    extraGroups = [ "networkmanager" "wheel" "kvm" "qemu" "libvirtd" ];
  };
}
