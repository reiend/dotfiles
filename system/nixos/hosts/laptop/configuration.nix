{ ... }:

{
  imports =
    [
      ./hardware.nix
      ./../../utils
      ./../../profiles/gui
      ./../../users/reiend
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];

  services.libinput.enable = true;
  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
