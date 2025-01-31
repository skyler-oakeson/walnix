{ ... }:
{ config, lib, ... }: 
{
  imports = [
    import ./hypr.nix { inherit config lib; }
    import ./kitty.nix { inherit config lib; }
  ];
}
