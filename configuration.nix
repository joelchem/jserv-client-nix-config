# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/wireguard.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   
  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
  
  
  networking.hostName = "jserver2";
  time.timeZone = "America/New_York";

  services.xserver.xkb.layout = "us";
  services.openssh = {
    enable = true;
  }; 
 
  users.users.joelchem = {
    isNormalUser = true;
    description = "Joel";
    extraGroups = [ "wheel" "docker"];
    shell = pkgs.bash;
    home = "/home/joelchem";
  };

  users.users.joelchem.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYgINk300qVFOkS98l1rP4MU2r9aw1UGqRlCluR0vnWMNILhGdLZWRk9R2OdJ3xcCCem0CI/p8SBQs5alHBPk66kMO3+kcYEYRJ0clVRwDT6DDTdvWgYkj0IsXl42oOoSeJQ2Yf2eNLLXhEM1aSBPnPRr+EV0d9Z5HkmXDJBsItKHViqUDRwgj8nPAu8Zvq42HfcpCeXGOh97c41Vglg7hSQht2IekAgcxVn1vfXqh5NtR/JOfidtNd5JIMd2GEFUkz7SkiA2VMEDX1SrgTxK98IAxeby0LEjgFs/Y/+Vfs6xtbSjYyThpXqdwrhaIcVOfApkdS+U1Ydm5qRfWZRMR joelchem"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEvAx5YehYS95U1lppIiUvQEmztx3APrK516UF117tz1 joelchem"
  ];

  boot.loader.grub.device = "nodev";
  
  environment.systemPackages = with pkgs; [ 
    vim
    wget
    wireguard-tools
    git
    tree
  ];
  
  virtualisation.docker.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

