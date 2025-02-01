{ ... }:
{ pkgs, config, lib, ... }:
let
  cfg = config.walnix;
  scheme = lib.importJSON (pkgs.runCommand "scheme" { 
      HOME = "./";
    } ''
      ${pkgs.wallust}/bin/wallust run -k \
      ${cfg.path} \
      --backend ${cfg.backend} \
      --palette dark16 \
      --colorspace lab \
      --saturation 20 \
      --threshold 5

      cat .cache/wallust/*.json > $out
    '');
in
{
  options.walnix = with lib; {
    enable = mkEnableOption { description = "Theme your desktop";
      default = false;
    };

    path = mkOption {
      type = types.path;
    };

    scheme = mkOption {
      type = types.oneOf [
        types.path
        types.attrs
        types.lines
      ];
    };

    backend = mkOption {
      type = types.enum [
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

    alpha = mkOption {
      type = types.nullOr types.ints.between 0 100;
    };
  };

  config = 
  let
    conversion = import ../../lib/conversions.nix { inherit lib config; };
  in
  {
    lib.walnix.colors = with conversion; { 
      hex = scheme;
      noHash = noHashTagAttrs scheme;
      rgb = rgbStringAttrs scheme;
    };
  } // import ./modules { inherit config lib; };
}
