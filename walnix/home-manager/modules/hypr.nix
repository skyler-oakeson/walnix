{ config, lib, ... }: 

{
  config = lib.mkIf (
    config.walnix.enable &&
    config.wayland.windowManager.hyprland.enable
  )
  ( 
   let
     inherit (config.walnix.colors) rgba;
   in
   with rgba; {
      wayland.windowManager.hyprland.settings = {
      general = {
        "col.active_border" = color5;
        "col.inactive_border" = color1;
      };
      group = {
        "col.border_inactive" = color1;
        "col.border_active" = color0;
        "col.border_locked_active" = color3;
      
        groupbar = {
          text_color = color5;
          "col.active" = color1;
          "col.inactive" = color0;
        };
      };
      decoration.shadow = {
        color = "0x66000000";
      };
      };
    }
  );
}

