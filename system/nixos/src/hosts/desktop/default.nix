# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{ imports =
    [ 
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
      ./nixkpgs.nix

      ./../../common/users/reiend
      ./../../common/time/asia-manila.nix
    ];
}
