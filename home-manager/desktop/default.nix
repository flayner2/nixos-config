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
  };

  colorScheme = nix-colors.colorSchemes.gruvbox-material-dark-medium;

  programs.home-manager.enable = true;
}
