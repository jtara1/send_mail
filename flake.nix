{
  description = "simple command-line for sending an email with remote auth";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable-small";
    poetry2nix.url = "github:nix-community/poetry2nix";
    poetry2nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, nixpkgs, poetry2nix }:
    let
      system = "x86_64-linux";
      pkgs = (import nixpkgs { inherit system; });
      _poetry2nix = (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; });
      mkPoetryApplication = _poetry2nix.mkPoetryApplication;
      send-mail-pkg = mkPoetryApplication { projectDir = ./.; };
    in {
      packages.${system} = rec {
        send-mail = send-mail-pkg;
        default = send-mail;
      };
    };
}
