{ ... }: {
  pkgs, 
  lib, 
  config,
  ...
}:
with lib; 
  let
    conversion = import ../../lib/conversions.nix { inherit lib config; };
    cfg = config.walnix;
    scheme = lib.importJSON (pkgs.runCommand "scheme" { 
        HOME = "./";
      } ''
        ${pkgs.wallust}/bin/wallust run ${cfg.path} \
        --backend ${cfg.backend} 

        cat .cache/wallust/*.json > $out
      '');
  in {
  options.walnix = {

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

  config = {
    lib.walnix.colors = { 
      hex = scheme;
      noHash = conversion.noHashTagAttrs scheme;
      rgb = conversion.rgbStringAttrs scheme;
    };
  }; 
}
