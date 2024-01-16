{
  description = "Maycon's NixOS Flake";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs
  inputs = {
    # Official NixOS pacakge source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    # Unstable NixOS package source
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # home-manager, for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      # The 'follows' keyword in inputs is used for inheritance.
      # This syncs the 'inputs.nixpkgs' of home-manager and the current flake,
      # avoiding problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Makes is easy to implement colorschemes from within Nix files
    # and easy to switch between colorschemes
    nix-colors.url = "github:misterio77/nix-colors";

    # My custom NixVim flake
    nixvim-flake.url = "github:flayner2/nixvim-flake-config";
  };

  # Outputs are the build results of the flake.
  # Parameters are defined in "inputs" and are referenced by their names
  # with the exception of the special keyword "self".
  outputs = { 
    self, 
    nixpkgs, 
    home-manager, 
    nix-colors, 
    unstable, 
    nixvim-flake, 
    ... 
  }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    nixosConfigurations = {
      maycon = nixpkgs.lib.nixosSystem {

        modules = [
          ./hosts/maycon
          
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

	    home-manager.extraSpecialArgs = inputs;
            home-manager.users.maycon = import ./home-manager/desktop;
          }
        ];

	specialArgs = { inherit inputs; };
      };
    };
  };
}
