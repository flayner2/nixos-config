# Hyprland configuration
{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };
}
