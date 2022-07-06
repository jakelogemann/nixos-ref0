{
  pkgs,
  lib,
  ...
}: with pkgs; {
  environment.systemPackages = [
    alejandra
    jq
    bat
    lsd
    dogdns
  ];
}
