{ pkgs, lib, nixpkgs, nixpkgs-unstable, comma, ... }:
{
  imports = [ ../profiles/aarch64-server.nix ../profiles/syslinux-boot.nix ];

  networking.hostname = "hecate";
  # Set up IPv4 & IPv6.
  networking.interfaces.eth0.useDHCP = true;
}
