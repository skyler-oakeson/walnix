{ pkgs, config, lib }: 
{
  config = lib.mkIf (
      config.walnix.enable &&
      config.kitty.enable
    )
    ( 
      {
        programs.kitty.settings =
          let
            inherit (config.lib.walnix.rgb) colors;
          in
          {
            background = "${colors.hex.background}";
            foreground = "${colors.hex.foreground}";
            selection_background = "${colors.hex.foreground}";
            selection_foreground = "${colors.hex.background}";
            url_color = "${colors.hex.color04}";
            cursor = "${colors.hex.color05}";
            cursor_text_color = "${colors.hex.color00}";
            active_border_color = "${colors.hex.color03}";
            inactive_border_color = "${colors.hex.color01}";
            active_tab_background = "${colors.hex.color00}";
            active_tab_foreground = "${colors.hex.color05}";
            inactive_tab_background = "${colors.hex.color01}";
            inactive_tab_foreground = "${colors.hex.color04}";
            tab_bar_background = "${colors.hex.color01}";
            wayland_titlebar_color = "${colors.hex.color00}";
            macos_titlebar_color = "${colors.hex.color00}";

            # normal
            color0 = "${colors.hex.color00}";
            color1 = "${colors.hex.color08}";
            color2 = "${colors.hex.color11}";
            color3 = "${colors.hex.color10}";
            color4 = "${colors.hex.color12}";
            color5 = "${colors.hex.color13}";
            color6 = "${colors.hex.color14}";
            color7 = "${colors.hex.color05}";

            # bright
            color8 = "${colors.hex.color03}";
            color9 = "${colors.hex.color08}";
            color10 = "${colors.hex.color12}";
            color11 = "${colors.hex.color10}";
            color12 = "${colors.hex.color14}";
            color13 = "${colors.hex.color15}";
            color14 = "${colors.hex.color13}";
            color15 = "${colors.hex.color07}";

            # extended color16 colors
            color16 = "${colors.hex.color09}";
            color17 = "${colors.hex.color15}";
            color18 = "${colors.hex.color01}";
            color19 = "${colors.hex.color02}";
            color20 = "${colors.hex.color04}";
            color21 = "${colors.hex.color06}";
        };
      }
   );
}
