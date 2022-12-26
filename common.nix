{ pkgs, lib, ... }:

{
  networking.nameservers = [ "172.16.1.1" ];
  services.resolved.enable = true;
  services.resolved.dnssec = "false";

  users.users.root.password = "nixos";
  services.sshd.enable = true;
  services.openssh.permitRootLogin = lib.mkDefault "yes";
  services.openssh.passwordAuthentication = false;
  services.getty.autologinUser = lib.mkDefault "root";

  time.timeZone = "Europe/Stockholm";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    bind
    neovim
  ];


  system.stateVersion = "22.11";
}
