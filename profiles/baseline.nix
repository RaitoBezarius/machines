{ pkgs, ... }:
{
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  environment.systemPackages = with pkgs; [
    wget vim htop iotop
    sysstat dstat smartmontools
    perf-tools mtr mosh
  ];
}
