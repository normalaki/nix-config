{
  description = "A very cool Nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs-26-05.url = "github:nixos/nixpkgs/nixos-26.05";
    
    /*aerothemeplasma-nix = {
      url = "github:nyakase/aerothemeplasma-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };*/

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /*nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };*/

    nixvim = {
      url = "github:nix-community/nixvim";
    };

    /*noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };*/
    /*plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };*/
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
	specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          #aerothemeplasma-nix.nixosModules.aerothemeplasma-nix
          home-manager.nixosModules.home-manager
          nixvim.nixosModules.nixvim
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.andrew = ./home.nix;
              backupFileExtension = "bak";
            };

	    #nix.registry.nixpkgs-26-05.flake = inputs.nixpkgs-26-05; 
          }
        ];
      };
    };
}
