{ config, lib, ... }: 

lib.mkIf (
    config.walnix.enable &&
    config.wayland.windowManager.hyprland.enable
 )
 ( 
   let
     inherit (config.lib.walnix.colors) rgb;
   in
   {
     general = {
       "col.active_border" = rgb.color5;
       "col.inactive_border" = rgb.color1;
     };
     group = {
       "col.border_inactive" = rgb.color1;
       "col.border_active" = rgb.color0;
       "col.border_locked_active" = rgb.color3;
 
       groupbar = {
         text_color = rgb.color5;
         "col.active" = rgb.color1;
         "col.inactive" = rgb.color0;
       };
     };
     decoration.shadow = {
       color = "0x66000000";
     };
   }
)

