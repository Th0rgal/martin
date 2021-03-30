{ config, pkgs, ... }:

{

  imports = [ 
      ./hardware-configuration.nix
      ./users.nix
      ./fonts.nix
      ./packages.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
    cleanTmpDir = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "ericzemmour";
    networkmanager.enable = true;
    #nameservers = [ "1.1.1.1" "9.9.9.9" ];
    firewall = {
      allowPing = true;
      allowedTCPPorts = [ 8080 ];
    };
  };

  # basic system config
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };
  i18n.defaultLocale = "fr_FR.UTF-8";
  time.timeZone = "Europe/Paris";

  system.stateVersion = "20.09";
  nixpkgs.config.allowUnfree = true;

}
