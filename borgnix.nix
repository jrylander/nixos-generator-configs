{ pkgs, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  services.sshd.enable = true;

  users.users.root.password = "nixos";
  services.openssh.permitRootLogin = lib.mkDefault "yes";
  services.getty.autologinUser = lib.mkDefault "root";

  services.borgbackup.repos = {
    nuc = {
      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPUuhDB9ZFFJhX+8ZvcXCVBG6HuJv6IW2SwTwcjfEGwj root@pve-r430"
      ] ;
      path = "/borg/repos/nuc" ;
    };
    mailbackup = {
      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICFKxCuVeFCQvz18yRJQcF0gB/5LXy8WiF9bfSC/C8Ty root@pve-r430"
      ] ;
      path = "/borg/repos/mailbackup" ;
    };
    syncthing-server = {
      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA78ecQaIJt6LjahNxLa7/yzOOwh78mBZ7U2qno59O11 root@pve-r430"
      ] ;
      path = "/borg/repos/syncthing-server" ;
    };
  };


  environment.systemPackages = with pkgs; [
    neovim
  ];

  system.stateVersion = "22.11";
}
