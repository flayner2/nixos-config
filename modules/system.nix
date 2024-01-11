{ pkgs, lib, inputs, ... }:

let 
  username = "maycon";
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maycon = {
    isNormalUser = true;
    description = "Maycon";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nix.settings = {
    # Users trusted to add new substituters
    trusted-users = [ "maycon" ];

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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Fonts
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
      serif = [ "Noto Serif" "Noto Color Emoji" ];
      sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
      monospace = [ "DejaVuSansM Nerd Font" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  programs.dconf.enable = true;

  # Enable zsh for all users
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Disable firewall
  networking.firewall.enable = false;

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = false; # Use pipewire instead
  security.rtkit.enable = true;

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

    # Udev
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Terminal
    alacritty

    # Files
    xfce.thunar
    ranger
    zathura

    # Archives
    zip
    unzip

    # Utils
    ripgrep # grep but rust
    fzf # Fuzzy finder
    eza # ls but rust
    jq # Command line JSON parser
    rsync # Transfer/copy utility
    fd # find but rust
    du-dust # du but rust
    which # Find path to executable
    tree # Pretty-print directory tree
    bat # cat but rust (with coloring)

    # Misc
    tealdeer # TLDR alternative in rust, example based man pages
    glow # Terminal-based markdown renderer
    zotero # Citation manager
    spotify
    pavucontrol

    # Diagnostics
    btop # Hardware (CPU + RAM)
    iotop # IO opeartions
    iftop # Network

    # Waybar
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )

    # Wayland utils
    dunst # Notifications - TODO: replace with `eww`
    wl-clipboard # Clipboard
    libnotify # Dependency for dunst 
    swww # Wallpaper manager
    rofi-wayland # App launcher
    networkmanagerapplet # Applet for Networkmanager
    polkit_gnome # Authentication agent
    qt6.qtwayland
    grimblast # Screenshot

    # Web
    firefox-devedition
    
    # Dev
    ## Tools
    git
    #neovim
    inputs.nixvim-flake.packages.${system}.default # nixvim instead of neovim
    ## R
    (rWrapper.override { packages = with rPackages; [ ggplot2 dplyr ape phytools ggpubr ]; })
    (rstudioWrapper.override { packages = with rPackages; [ ggplot2 dplyr ape phytools ggpubr ]; })
    ## Rust
    rustc
    cargo
    rust-analyzer
    ## Python
    (python3.withPackages(ps: with ps; [ pip numpy pandas biopython ]))
    pipx
    black
    ruff
    ruff-lsp
    ## Node
    nodejs_21
    ## Libs
    zlib
    ## C
    gcc
    cmake
    pkg-config
    clang
    llvmPackages_17.bintools

    # HTTP
    wget
    curl

    # Sys
    os-prober
    grub2
    udisks
    efibootmgr
    pciutils
    usbutils
  ];

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
