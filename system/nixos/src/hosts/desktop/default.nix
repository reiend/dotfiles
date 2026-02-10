_: {
  imports = [
    ./boot.nix
    ./hardware-generated.nix
    ./hardware.nix
    ./system.nix
    ./security.nix
    ./networking.nix
    ./services.nix
    ./i18n.nix
    ./programs.nix
    ./environment.nix
    ./nixpkgs.nix

    ./../../common/users/reiend
    ./../../common/time/asia-manila.nix
  ];
}
