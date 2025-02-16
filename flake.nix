{
  description = "My NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, home-manager, stylix, ... } @ inputs: 
  # let
    # pkgs = nixpkgs.legacyPackages.x86_64-linux;
    # pkgs = import nixpkgs {
    #   system = "x86_64-linux";
    # };
  # in
  {
    # packages.x86_64-linux.hello = pkgs.hello;
    # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        (
	        {pkgs, ...}: {
	          home-manager = {
              useGlobalPkgs = true;
	            useUserPackages = true;
	            users.morswin.imports = [ ./home.nix ];
	          };
	        }
	      )
      ];
    };
  };
}
