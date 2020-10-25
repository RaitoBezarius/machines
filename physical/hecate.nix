{ lib, ... }:
{
  deployment.targetEnv = "none";
  deployment.targetHost = "hecate.v6.lahfa.xyz";

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/0f9f1a1c-c225-469b-81be-ea4bf4b58455";
      fsType = "btrfs";
      options = [ "space_cache" "noatime" "compress=zstd" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/54F4-27DC";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
