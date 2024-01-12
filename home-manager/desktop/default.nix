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
  };

  colorScheme = nix-colors.colorSchemes.gruvbox-material-dark-medium;

  programs.home-manager.enable = true;
}
