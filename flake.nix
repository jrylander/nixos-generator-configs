{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11-small";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }: {
    packages.x86_64-linux = {
      borgnix = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          ./borgnix.nix
        ];
        format = "proxmox-lxc";
      };
      syncnix = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          ./syncnix.nix
        ];
        format = "proxmox-lxc";
      };
    };
  };
}
