{
  description = "Walnix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    base16-schemes = {
        url = "github:tinted-theming/base16-schemes";
        flake = false;
    };

    flake-compat = {
      flake = false;
      url = "github:edolstra/flake-compat";
    };
  };

  outputs = { self, nixpkgs, base16-schemes, ... }@inputs : 
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs { inherit system; };
  in
  {
  homeManagerModules.walnix = 
    { pkgs, ... }@args:
    {
      imports = [
        (import ./home-manager inputs {
          inherit base16-schemes;
          homeManagerModule = self.homeManagerModules.walnix;
        })
      ];
    };
  };
}
