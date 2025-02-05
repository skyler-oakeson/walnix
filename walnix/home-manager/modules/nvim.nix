{ config, lib, pkgs, ... }: 

{
  config = lib.mkIf (
    config.walnix.enable &&
    config.programs.neovim.enable
  )
  ( 
   let
     inherit (config.walnix.colors) hex;
   in
   with hex; {
      programs.neovim = {
      plugins = [
        {
          plugin = pkgs.vimPlugins.mini-base16;
          type = "lua";
          config = with config.walnix.colors.hex; ''
            require('mini.base16').setup({
              palette = {
                 base00 = '${background}',  base01 = '${color1}',      base02 = '${color2}',  base03 = '${color3}',
                 base04 = '${color4}',      base05 = '${foreground}',  base06 = '${color6}',  base07 = '${color7}',
                 base08 = '${color8}',      base09 = '${color9}',      base0A = '${color10}', base0B = '${color11}',
                 base0C = '${color12}',     base0D = '${color13}',     base0E = '${color14}', base0F = '${color15}'
              }
            })
          '';
        }
      ];
  
      # This isn't working
      extraLuaConfig = ''
        -- transparent background
        vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" })
        vim.cmd.highlight({ "NonText", "guibg=NONE", "ctermbg=NONE" })
  
        -- transparent signcolumn
        vim.cmd.highlight({ "SignColumn", "guibg=NONE", "ctermbg=NONE" })
      '';
      };
    }
  );
}

