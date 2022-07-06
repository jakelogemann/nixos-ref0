{
  description = "ref";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/22.05";
    nix-cue.url = "github:jmgilman/nix-cue";
    nix-cue.inputs.nixpkgs.follows = "nixpkgs";
    nix-cue.inputs.flake-utils.follows = "flake-utils";
    flake-utils.url = "github:numtide/flake-utils";
    fnctl.url = "github:fnctl/nix/main";
    fnctl.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {self, fnctl, nixpkgs, ...}@inputs: {
    nixosConfigurations.ref = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [ 
        ({lib,...}: {
          nix.registry = with lib; mapAttrs' (name: value: nameValuePair name {flake = value;}) inputs;
        })
        ./configuration.nix 

      ];
      specialArgs = {
        inherit system;
        inherit (inputs) fnctl nixpkgs;
      };
    };
  };
}
