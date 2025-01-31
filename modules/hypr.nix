{ pkgs, config, lib }: 
{
  config = lib.mkIf (
      config.walnix.enable &&
      config.wayland.windowManager.hyprland.enable
    )
    ( 
      {
        wayland.windowManager.hyprland.settings =
          let
            inherit (config.lib.walnix.rgb) colors;
          in
          {
          general = {
            "col.active_border" = colors.color0;
            "col.inactive_border" = colors.color1;
          };
          group = {
            "col.border_inactive" = colors.color1;
            "col.border_active" = colors.color0;
            "col.border_locked_active" = colors.color3;
   
            groupbar = {
              text_color = colors.color5;
              "col.active" = colors.color1;
              "col.inactive" = colors.color0;
            };
          };
          decoration.shadow = {
            color = "0x66000000";
          };
        };
      }
   );
}
