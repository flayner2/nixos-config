{ pkgs, config, ... }:
let
  font_family = "DejaVuSansM Nerd Font";
  font_size = 12;
in
{
  programs.alacritty.settings.font = {
    size = font_size;

    normal = {
      family = font_family;
    };
  };
}
