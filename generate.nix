{ pkgs ? import <nixpkgs> { }, path, ... }:
let
generated = pkgs.stdenv.mkDerivation {
  name = "generated-colors";
  env = {
    HOME = "./";
  };
  unpackPhase = "true";
  nativeBuilInputs = with pkgs; [ wallust ];
  buildPhase = ''
    wallust run ${path}
  '';
  postInstall = 
  ''
    mkdir $out
    cp -v .cache/wallust/*.json $out/color-scheme.json
  '';
};
in
builtins.fromJSON (builtins.readFile "${builtins.toString generated}/color-scheme.json")
