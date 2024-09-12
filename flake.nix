{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # https://github.com/nix-community/nixGL
    # nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { nixpkgs, ... } @ inputs: 
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    # pkgs = import nixpkgs {
    #   system = "x86_64-linux";
    # };
  in
  {
    # packages.x86_64-linux.hello = pkgs.hello;
    # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
