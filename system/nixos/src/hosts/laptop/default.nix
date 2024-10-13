_: {
  imports = [
      ./hardware-generated.nix
      ./boot.nix
      ./hardware.nix
      ./services.nix
      ./security.nix
      ./system.nix
      ./../../common/profiles/gui
      ./../../common/users/reiend
      ./../../common/time/asia-manila.nix
  ];

}
