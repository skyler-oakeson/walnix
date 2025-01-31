{
  description = "Walnix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs : 
  {
    homeManagerModules = {
      walnix = import ./walnix/home-manager/module.nix { };
      modules = import ./modules { };
      default = self.homeManagerModules.walnix;
    };
  };
}
