{ pkgs, config, ... }:

{
  imports = [
    ./colours.nix # Colourscheme
    ./fonts.nix # Fonts
  ];

  programs.alacritty = {
    enable = true;

    # Alacritty config
    settings = {
      env.TERM = "xterm-256color";

      # Window
      window = {
	# 1.0 is opaque, 0.0 is fully transparent
        opacity = 0.9;
      };
    };
  };
}
