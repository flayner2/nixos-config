{ config, ... }:

{
  programs.alacritty.settings.colors = with config.colorScheme.colors; {
    draw_bold_text_with_bright_colors = false;

    primary = {
      foreground = "#${base05}";
      background = "#${base00}";
      dim_foreground = "#${base04}";
      bright_foreground = "#${base06}";
    };

    normal = {
      # This "black" controls the comments colour
      black = "#${base02}";
      red = "#${base08}";
      green = "#${base0B}";
      yellow = "#${base0A}";
      blue = "#${base0D}";
      magenta = "#${base0E}";
      cyan = "#${base0C}";
      white = "#${base05}";
    };

    bright = {
      # This "black" controls the zsh autocomplete colour
      black = "#${base03}";
      red = "#${base08}";
      green = "#${base0B}";
      yellow = "#${base0A}";
      blue = "#${base0D}";
      magenta = "#${base0E}";
      cyan = "#${base0C}";
      white = "#${base05}";
    };

    dim = {
      black = "#${base01}";
      red = "#${base08}";
      green = "#${base0B}";
      yellow = "#${base0A}";
      blue = "#${base0D}";
      magenta = "#${base0E}";
      cyan = "#${base0C}";
      white = "#${base05}";
    };
  };
}
