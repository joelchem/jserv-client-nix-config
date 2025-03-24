{ config, pkgs, ... }:

{
  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.0.0.2/24" ];
      privateKeyFile = "/etc/nixos/secrets/wireguard-private-key";

      autoStart = true;
      
      # Add systemd service configuration
      extraConfig = ''
        [Service]
        Restart=always
        RestartSec=30
      '';

      peers = [
        {
          publicKey = "DLldRU+4PxZfehDSFRLSSp6Cc1CKyTKtUC0ZfTu51CE=";
          allowedIPs = [ "10.0.0.0/24" ];
          endpoint = "jserv.joelchem.com:31416";
          persistentKeepalive = 25;
        }
      ];
    };
  }; 
}
