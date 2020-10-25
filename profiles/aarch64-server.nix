{ pkgs, ... }:
{
  imports = [ ./baseline-server.nix ];

  nixpkgs.localSystem.system = "aarch64-linux";
}
