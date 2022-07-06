{
  pkgs,
  lib,
  ...
}: with pkgs; {
  environment.systemPackages = [
    alejandra
    jq
    skim
    navi
    bat
    lsd
    dogdns
  ];
}
