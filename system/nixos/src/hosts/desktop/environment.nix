{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
       vim
       openssl_3_3
    ];
  };
}
