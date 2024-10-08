{ ... }:

{
  imports = [
    ./../../users/reiend
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  system.stateVersion = "24.05";
}
