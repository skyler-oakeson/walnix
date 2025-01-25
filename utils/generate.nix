{ config, pkgs, lib, ... }:
let
cfg = config.walnix;

generatedJSON = pkgs.stdenv.mkDerivation {
  pname = "generated-colors";
  version = "v0.0.1";
  env = {
    HOME = "./";
  };
  unpackPhase = "true";
  nativeBuildInputs = with pkgs; [ wallust ];
  buildPhase = ''
    wallust run ${cfg.path}
  '';
  postInstall = 
  ''
    mkdir $out
    cp -v .cache/wallust/*.json $out/color-scheme.json
  '';
};

scheme = builtins.fromJSON (builtins.readFile generatedJSON);

in
{
  options.walnix = {
    path = lib.mkOption {
      type = lib.types.path;
    };

    backend = lib.mkOption {
      type = lib.types.enum [
        "full"
        "resized"
        "wal"
        "thumb"
        "fastresize"
      ];
      description = ''
        Use this option to dictate which backend to wallust will use to generate a pallette.

        Default is selected by Wallust
      '';
    };

    alpha = lib.mkOption {
      type = lib.types.ints.between [
        0
        100
      ];
    };
  };
}
