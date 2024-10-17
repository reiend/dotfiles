{ pkgs, ... }:
{
  imports = [ <home-manager/nixos> ];

  users = {
    users = {
      reiend = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };
    };
  };

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "Lekton" ]; }) ];

  environment.systemPackages = with pkgs; [
    stylua
    lua-language-server
    luajitPackages.luacheck
    nil
    clang_18
    clang-tools
    ripgrep
    nixfmt-rfc-style
    nodePackages_latest.typescript-language-server

    libGL
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.users.reiend = {
    imports = [ ./programs.nix ];

    home.stateVersion = "24.05";
  };
}
