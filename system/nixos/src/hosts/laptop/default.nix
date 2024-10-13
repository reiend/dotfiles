_: {
  imports = [
      ./hardware-generated.nix
      ./boot.nix
      ./hardware.nix
      ./system.nix
      ./security.nix
      ./networking.nix
      ./services.nix
      ./i18n.nix
      ./programs
      ./environments
      ./nixkpgs.nix

      ./../../common/users/reiend
      ./../../common/time/asia-manila.nix
  ];
}
