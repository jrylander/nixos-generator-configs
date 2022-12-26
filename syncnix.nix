{ pkgs, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    ./common.nix
  ];

  networking.firewall.allowedTCPPorts = [ 8384 22000];
  networking.firewall.allowedUDPPorts = [ 22000 21027];

  services = {
    syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
      user = "syncthing";
      dataDir = "/syncthing";
      configDir = "/syncthing/config";
    };
  };

  users.users.syncthing = {
    home = "/syncthing";
  };

  services.borgbackup.jobs = {
    borgnix = {
      paths = [ "/syncthing" ];
      doInit = true;
      repo =  "borg@borgnix.rylander.cc:/borg/repos/syncthing" ;
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat /run/keys/borgbackup_passphrase";
      };
      environment = { BORG_RSH = "ssh -i /run/keys/id_ed25519_syncthing-server"; };
      compression = "auto,lzma";
      startAt = "hourly";
    };
  };


  system.stateVersion = "22.11";
}
