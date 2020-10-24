{ pkgs, ... }:
{
  imports = [ ../users/servers.nix ./baseline.nix ];

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}
