{

 imports = [
   ./git.nix
   ./gtk.nix
   ./shell.nix
   ./config.nix
   ./packages.nix
   ./environment.nix
 ];

 nixpkgs = {
   config = {
     allowUnfree = true;
     allowUnfreePredicate = (_: true);
     };
 };

}
