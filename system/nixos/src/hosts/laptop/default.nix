_: {
  imports = [
      ./hardware-generated.nix
      ./boot.nix
      ./hardware.nix
      ./system.nix
      ./services.nix
      ./security.nix
      ./i18n.nix
      ./nixkpgs.nix

      ./../../common/profiles/gui
      ./../../common/users/reiend
      ./../../common/time/asia-manila.nix
  ];
}
