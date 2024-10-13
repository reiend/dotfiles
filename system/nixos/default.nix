let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  rebuild = {
    wsl = pkgs.writeShellScriptBin "/rebuild/wsl" ''
      sudo nixos-rebuild switch -I nixos-config=./src/hosts/wsl
    '';
    laptop = pkgs.writeShellScriptBin "rebuild/laptop" ''
      cp /etc/nixos/hardware-configuration.nix ./src/hosts/laptop/hardware-generated.nix
      sudo nixos-rebuild switch -I nixos-config=./src/hosts/laptop
    '';
  };
}
