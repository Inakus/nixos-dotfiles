{ config, pkgs, ... }:

{
  services = {
  	dbus.enable = true;
	picom.enable = true;
	openssh.enable = true;
    spice-vdagentd.enable = true;

	xserver = {
		enable = true;
		xkb.layout = "pl";
		
	};
    displayManager = {
			sddm.enable = true;
            sddm.theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
		};
  };
}
