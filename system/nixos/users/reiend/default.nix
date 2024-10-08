{ ... }:

{
  users.users.reiend = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  programs.git = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
  };
}

