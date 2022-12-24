{ pkgs, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  services.sshd.enable = true;

  users.users.root.password = "nixos";
  services.openssh.permitRootLogin = lib.mkDefault "yes";
  services.getty.autologinUser = lib.mkDefault "root";

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

  environment.systemPackages = with pkgs; [
    neovim
  ];

  system.stateVersion = "22.11";
}
