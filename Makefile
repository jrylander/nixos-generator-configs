all: nixos-borgnix-system-x86_64-linux.tar.xz nixos-syncnix-system-x86_64-linux.tar.xz 

nixos-borgnix-system-x86_64-linux.tar.xz: borgnix.nix  common.nix  flake.lock  flake.nix
	rm -f result
	nix build .#borgnix
	cp -H result/tarball/nixos-system-x86_64-linux.tar.xz nixos-borgnix-system-x86_64-linux.tar.xz
	scp nixos-borgnix-system-x86_64-linux.tar.xz root@pve-r430.rylander.cc:

nixos-syncnix-system-x86_64-linux.tar.xz: borgnix.nix  common.nix  flake.lock  flake.nix
	rm -f result
	nix build .#syncnix
	cp -H result/tarball/nixos-system-x86_64-linux.tar.xz nixos-syncnix-system-x86_64-linux.tar.xz
	scp nixos-syncnix-system-x86_64-linux.tar.xz root@pve-r430.rylander.cc:
