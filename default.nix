{ pkgs ? import <nixpkgs> { }, path, ... }:
let
  scheme = import ./generate.nix { inherit pkgs path; };
in 
{ inherit scheme; }
