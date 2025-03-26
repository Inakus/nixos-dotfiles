{
    description = "My first flake!";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
        home-manager.url = "github:nix-community/home-manager/release-24.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        zen-browser.url = "github:0xc000022070/zen-browser-flake";
        hyprland.url = "github:hyprwm/Hyprland";
        nixvim = {
            url = "github:nix-community/nixvim/nixos-24.11";
            # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {self, nixpkgs, home-manager, zen-browser, ...} @ inputs :
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in{
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs; };
                modules = [
                    ./system/configuration.nix
                    home-manager.nixosModules.home-manager
		                        {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
                    }
                ];
            };
        };
        homeConfigurations = {
            karold = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                    ./home
                ];
                extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};

            };
        };
    };
}
