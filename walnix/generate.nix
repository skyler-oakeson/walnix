{ 
  config, 
  pkgs, 
  ... 
}: let cfg = config.walnix; in

pkgs.runCommand "scheme" { 
  HOME = "./";
} ''
  ${pkgs.wallust}/bin/wallust run ${cfg.path}
  cat .cache/wallust/*.json > $out
''
