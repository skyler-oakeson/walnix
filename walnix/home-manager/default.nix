{ inputs, ... }:
{ pkgs, config, lib, ... }:
let
  cfg = config.walnix;
  # modules = import "${inputs.self}/walnix/iterload.nix" { inherit lib inputs; };
  scheme = lib.importJSON (pkgs.runCommand "scheme" { 
      HOME = "./";
    } ''
      ${pkgs.wallust}/bin/wallust run \
      ${cfg.path} \
      ${if cfg.alpha != null then "--alpha ${builtins.toString cfg.alpha}" else ""} \
      ${if cfg.backend != null then "--backend ${cfg.backend}" else ""} \
      ${if cfg.checkContrast == true then "-k" else ""} \
      ${if cfg.colorSpace == true then "--colorspace ${cfg.colorSpace}" else ""} \
      ${if cfg.dynamicThreshold == true then (if cfg.threshold == null then "--dynamic-threshold" 
      else throw "dynamicThreshold and threshold cannot be defined simultaneously") else ""} \
      ${if cfg.fallbackGenerator != null then "--fallback-generator ${cfg.fallbackGenerator}" else ""} \
      ${if cfg.palette != null then "--palette ${cfg.palette}" else ""} \
      ${if cfg.saturation != null then "--saturation ${builtins.toString cfg.saturation}" else ""} \
      ${if cfg.threshold != null then (if cfg.dynamicThreshold == null then "--threshold ${builtins.toString cfg.threshold}"
      else throw "dynamicThreshold and threshold cannot be defined simultaneously") else ""} \
      ${if cfg.quiet == true then "-q" else ""}

      cat .cache/wallust/*.json > $out
    '');
in
{
  options.walnix = with lib; {
    enable = mkEnableOption { description = "Use Wallust to theme your apps.";
      default = false;
    };

    alpha = mkOption {
      type = types.nullOr (types.ints.between 0 100);
      default = 100;
    };

    backend = mkOption {
      type = types.nullOr (types.enum [
        "full"
        "resized"
        "wal"
        "thumb"
        "fastresize"
      ]);
      default = null;
    };

    checkContrast = mkOption {
      type = types.nullOr (types.bool);
      default = null;
    };

    colors = mkOption {
      type = types.attrs;
    };

    colorSpace = mkOption {
      type = types.nullOr (types.enum [
        "lab"
        "labmixed"
        "lch"
        "lchmixed"
        "lchansi"
      ]);
      default = null;
    };

    dynamicThreshold = mkOption {
      type = types.nullOr (types.bool);
      default = null;
    };

    fallbackGenerator = mkOption {
      type = types.nullOr (types.enum [
        "interpolation"
        "complementary"
      ]);
      default = null;
    };

    palette = mkOption {
      type = types.nullOr (types.enum [
        "dark"
        "dark16"
        "darkcomp"
        "darkcomp16"
        "darkansi"
        "harddark"
        "harddark16"
        "harddarkcomp"
        "light"
        "light16"
        "lightcomp"
        "lightcomp16"
        "softdark"
        "softdark16"
        "softdarkcomp"
        "softdarkcomp16"
        "softlight"
        "softlight16"
        "softlightcomp"
        "softlightcomp16"
      ]);
      default = null;
    };

    path = mkOption {
      type = types.path;
    };

    saturation = mkOption {
      type = types.nullOr (types.ints.between 1 100);
      default = null;
    };

    threshold = mkOption {
      type = types.nullOr (types.ints.between 1 100);
      default = null;
    };

    quiet = mkOption {
      type = types.nullOr (types.bool);
      default = null;
    };
  };

  config = 
  let
    conversion = import "${inputs.self}/lib/conversions.nix" { inherit lib config; };
  in
  {
    walnix.colors = with conversion; { 
      hex = scheme;
      noHash = toNoHashTagAttrs scheme;
      rgb = toRGBStringAttrs scheme;
      rgba = toRGBAStringAttrs scheme;
    };
  };

  # imports = modules;
}
