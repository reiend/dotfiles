_: {
  imports = [
    ./programs.nix
  ];

  users = {
    users = {
      reiend = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
      };
    };
  };
}

