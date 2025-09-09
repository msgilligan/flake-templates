{
  description = "Home Manger template for Go Developers and more";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs }:
    let
      # Can we use forAllSystems with Home Manager (this is a template after all)
      # System types to support.
      #supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      #forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      #nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ self.overlay ]; });

      system = "aarch64-linux";
      pkgs = import nixpkgs {
        system = system;
      };

    in {

      homeConfigurations."go-home" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          {
            home.username = "sean";
            home.homeDirectory = "/home/sean.linux";
            home.stateVersion = "25.11";
          }
          ./home.nix
        ];
      };
  };
}



