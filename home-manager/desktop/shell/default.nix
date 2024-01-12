{ config, pkgs, lib, ... }:

{
  imports = [
    ./terminal # Terminal emulators
    ./starship.nix # Starship
  ];

  # Fix ls colors
  programs.dircolors = {
    enable = true;

    settings = {
      # Bold blue foreground for directories
      # in "OTHER_WRITABLE" e.g. my HD Drive
      OTHER_WRITABLE = "1;34";
    };
  };

  # Enable Zsh
  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";

    # Aliases
    shellAliases = {
      # Terminal utils
      ll = "ls -l";
      ".." = "cd ..";
      vim = "nvim";

      # SSH connections
      lab = "ssh maycon@labbioinfo.icb.ufmg.br";
      lgm = "ssh -p 2772 maycon@150.164.28.21";
      sarapalha = "ssh flayner2@sarapalha.icb.ufmg.br";
    };

    # History
    history = {
      ignoreAllDups = true;
      # Don't add commented commands to history
      ignorePatterns = [ "#*" ];
      path = "${config.xdg.dataHome}/zsh/history";
      save = 10000;
      size = 10000;
      share = true;
    };

    # Enable plugins
    enableAutosuggestions = true;
    enableCompletion = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "colored-man-pages";
        src = pkgs.fetchFromGitHub {
             owner = "ael-code";
             repo = "zsh-colored-man-pages";
             rev = "57bdda68e52a09075352b18fa3ca21abd31df4cb";
             sha256 = "sha256-087bNmB5gDUKoSriHIjXOVZiUG5+Dy9qv3D69E8GBhs=";
        };
       }
       {
         name = "dircycle";
         src = pkgs.fetchFromGitHub {
             owner = "michaelxmcbride";
             repo = "zsh-dircycle";
             rev = "96ff0e884077d19904092b848cfd2512a42d659e";
             sha256 = "sha256-ZVbuCoQpRgXDCvTakYZ9hfIaKmaPU9dI3rjrLqFqJkE=";
         };
       }
    ];

    # Additional commands that should be added to
    # .zshr. The type is string, concatenated with \n
    initExtra = "setopt interactivecomments";
  };

  # Environment variables
  home.sessionVariables = {
    WINEPREFIX = "${config.xdg.dataHome}/wine";

    # Set default applications
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };
}
