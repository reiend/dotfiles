let
  nixpkgs = fetchTarball "channel:nixos-24.05";
  pkgs = import nixpkgs { };
in
{
  rebuild = {
    wsl = pkgs.writeShellScriptBin "/rebuild/wsl" ''
      sudo nixos-rebuild switch -I nixos-config=./src/hosts/wsl
    '';

    laptop = pkgs.writeShellScriptBin "rebuild/laptop" ''
      sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
      sudo nix-channel --update

      cp /etc/nixos/hardware-configuration.nix ./src/hosts/laptop/hardware-generated.nix
      sudo nixos-rebuild switch -I nixos-config=./src/hosts/laptop
    '';

    desktop = pkgs.writeShellScriptBin "rebuild/desktop" ''
      sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
      sudo nix-channel --update

      cp /etc/nixos/hardware-configuration.nix ./src/hosts/desktop/hardware-generated.nix
      sudo nixos-rebuild switch -I nixos-config=./src/hosts/desktop
    '';
  };
}
