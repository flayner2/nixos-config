{ pkgs, ... }:
let
  emoji_font = "Noto Color Emoji";
in
{
  fonts = {
    packages = with pkgs; [
      # Material icons
      material-design-icons

      # Normal fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      # Nerdfonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" "DejaVuSansMono" ]; })
    ];

    # Use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # User defined fonts
    # The emoji is everywhere to overwrite DejaVu's B&W emojis
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" emoji_font ];
      sansSerif = [ "Noto Sans" emoji_font ];
      monospace = [ "DejaVuSansM Nerd Font" emoji_font ];
      emoji = [ emoji_font ];
    };
  };
}
