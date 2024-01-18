{ pkgs, inputs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Terminal
    alacritty

    # Files
    xfce.thunar
    ranger
    zathura
    libreoffice-fresh

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

  ## Program configurations

  # Configuration storage system
  programs.dconf.enable = true;

  # Enable zsh for all users
  programs.zsh.enable = true;
  # Enables autocompletion for system packages in zsh
  environment.pathsToLink = [ "/share/zsh" ];

  # To open stuff
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Thunar file manager
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
}
