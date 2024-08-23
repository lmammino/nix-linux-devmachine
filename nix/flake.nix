{
  description = "Personal flake with commonly used software on VDI";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    # packages.x86_64-linux.default = inputs.home-manager.nixosModules.home-manager {
    #   # home-manager.useGlobalPkgs = true;
    #   inherit pkgs;
    #   lib = nixpkgs.lib;
    #   config = {};
    #   utils = nixpkgs.lib.utils;
    # };
    
    packages.x86_64-linux.default = pkgs.buildEnv {
      name = "luciano";
      paths = with pkgs; [
        bashInteractive
        home-manager
        starship
        python3
        nodejs_22
        corepack_22
        awscli2
        neofetch
        gh
      ];
    };
  };
}
