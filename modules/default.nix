{ pkgs, lib, inputs, ... }:
let 
  username = "maycon";
in 
{
  imports = [
    ./packages.nix
    ./users.nix
    ./locale.nix
    ./network.nix
    ./services.nix
    ./sound.nix
    ./fonts.nix
    ./hyprland.nix
    ./docker.nix
  ];

  nix.settings = {
    # Users trusted to add new substituters
    trusted-users = [ username ];

    # Enable experimental features
    experimental-features = [ "nix-command" "flakes" ];

    # Register substituters
    substituters = [
      "https://cache.nixos.org"
    ];
  };
  
  # Do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Dbus thread scheduler
  security.rtkit.enable = true;
  
  # Polkit configuration
  security.polkit = {
    enable = true;
    extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
