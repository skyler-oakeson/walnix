{ config, pkgs, lib, ...}:

import ../utils/generate.nix { inherit config pkgs lib; }
