{
  description = "simple command-line for sending an email with remote auth";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable-small";
  };

  outputs =
    { self, nixpkgs, poetry2nix }:
    let
      system = "x86_64-linux";
      pkgs = (import nixpkgs { inherit system; });
    in {
      packages.${system} = rec {
        send-mail = (import ./send-mail.nix { inherit pkgs; });
        default = send-mail;
      };
    };
}
