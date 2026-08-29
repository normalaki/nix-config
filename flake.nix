{
  description = "A very cool Nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    freesmlauncher.url = "github:FreesmTeam/FreesmLauncher/a8736ba17f4d6274f4351a1d7eeff8d0ced89355";

  };

  outputs = { self, nixpkgs, home-manager, nvf, freesmlauncher, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
	specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./nix-ld.nix
          #aerothemeplasma-nix.nixosModules.aerothemeplasma-nix
          home-manager.nixosModules.home-manager
          nvf.nixosModules.nvf
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.andrew = ./home.nix;
              backupFileExtension = "bak";
            };

            environment.systemPackages = [
              inputs.freesmlauncher.packages.${system}.freesmlauncher
            ];
          }
        ];
      };
    };
}
