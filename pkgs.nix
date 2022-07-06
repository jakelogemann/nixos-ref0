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
    direnv
    zoxide
    bat
    lsd
    dogdns
    (writeShellScriptBin "nixos-repl" "exec nix repl '<nixpkgs/nixos>'")
  ];
}
