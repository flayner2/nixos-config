{ config, pkgs, nix-colors, ... }:

{
  imports = [
    ./shell
    ./programs
    ./nvim
    nix-colors.homeManagerModules.default
  ];
  
  home = {
    username = "maycon";
    homeDirectory = "/home/maycon";

    stateVersion = "23.11";

    # Copy wallpaper file to home
    file."Wallpapers/wallpaper.png".source = ../../assets/images/wallpaper.png;

    # Environment variables
    sessionVariables = {
      WINEPREFIX = "${config.xdg.dataHome}/wine";
    
      # Set default applications
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "alacritty";
    };

    # Cursor theme
    pointerCursor = {
      gtk.enable = true;
      x11.enable = true; # Not sure if I need this
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Gruvbox)";
      size = 12;
    };
  };

  colorScheme = nix-colors.colorSchemes.gruvbox-material-dark-medium;

  programs.home-manager.enable = true;
}
