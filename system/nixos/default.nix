let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  rebuildWSL = pkgs.writeShellScriptBin "rebuild_wsl" ''
    cp /etc/nixos/hardware-configuration.nix ./src/hosts/wsl/hardware-generated.nix
    sudo nixos-rebuild switch -I nixos-config=./src/hosts/wsl
  '';

  rebuildLaptop = pkgs.writeShellScriptBin "rebuild_laptop" ''
    cp /etc/nixos/hardware-configuration.nix ./src/hosts/laptop/hardware-generated.nix
    sudo nixos-rebuild switch -I nixos-config=./src/hosts/laptop
  '';
}
