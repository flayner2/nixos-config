{ pkgs, ... }:

{
  # Configure services 
  services = {
    # Enable the OpenSSH daemon
    openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
	PermitRootLogin = "no";
	PasswordAuthentication = false;
      };
      openFirewall = true;
    };

    # Udisks2 - utility to mount devices
    udisks2.enable = true;

    # Sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Manages device events
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };
}
