{ config, lib, ... }: 
{
  wayland.windowManager.hyprland.settings = import ./hypr.nix { inherit config lib; };
  programs.kitty = import ./kitty.nix { inherit config lib; };
}
