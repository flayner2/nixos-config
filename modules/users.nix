{ pkgs, ... }:

{
  # Define a user account
  users.users.maycon = {
    isNormalUser = true;
    description = "Maycon";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  # Set zsh as the default shell for all users
  users.defaultUserShell = pkgs.zsh;
}
