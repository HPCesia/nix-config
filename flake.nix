{
  description = "NixOS configuration of HPCesia.";

  outputs = inputs: import ./outputs inputs;

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nu-scripts = {
      url = "github:nushell/nu_scripts";
      flake = false;
    };

    # === Follows are myself repos === #
    nur-hpcesia = {
      url = "github:HPCesia/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "github:HPCesia/Wallpapers";
      flake = false;
    };

    nixos-logo = {
      url = "github:HPCesia/nixos-logo";
      flake = false;
    };
  };
}
