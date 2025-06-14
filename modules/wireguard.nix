{ config, pkgs, ... }:

{
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.0.0.2/24" ];
      privateKeyFile = "/etc/nixos/secrets/wireguard-private-key";

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

