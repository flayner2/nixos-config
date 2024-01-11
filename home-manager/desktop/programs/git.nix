{ pkgs, ... }:

{
  home.packages = [ pkgs.lazygit ];

  programs.git = {
    enable = true;
    userName = "Maycon Oliveira";
    userEmail = "flayner5@gmail.com";
  };
}
