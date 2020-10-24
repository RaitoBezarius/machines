{
  description = "RaitoBezarius's cute infrastructure";

  inputs = {
    # Used by the core system config
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Used by the dev shell
    flake-utils.url = "github:numtide/flake-utils";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      flake = false;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Used by home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-20.09";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    comma = {
      url = "github:Shopify/comma";
      flake = false;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager
    , comma, ... }:
    let
      x86System = "x86_64-linux";
      aarch64System = "aarch64-linux";
      overlay-unstable = system: final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in {
      nixosConfigurations.pine-a64-hecate = nixpkgs.lib.nixosSystem {
        system = aarch64System;
        modules = [
          ({ lib, config, pkgs, ... }: {
            imports = [
              (import ./physical/hecate.nix {
                inherit pkgs;
              })
              (import ./machines/hecate.nix {
                inherit pkgs lib nixpkgs nixpkgs-unstable home-manager comma;
              })
              (import ./common/flake-conf.nix {
                inherit pkgs nixpkgs nixpkgs-unstable;
              })
            ];
            nixpkgs.overlays = [ (overlay-unstable aarch64System) ];
            nixpkgs.config.allowUnfree = true;
            system.configurationRevision =
              nixpkgs.lib.mkIf (self ? rev) self.rev;
              nix.registry.nixpkgs.flake = nixpkgs;
          })
        ];
      };
    };
  }
