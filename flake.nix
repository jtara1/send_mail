{
  description = "simple command-line for sending an email with remote auth";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable-small";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = (import nixpkgs { inherit system; });
    in {
      packages.x86_64-linux.send-mail = (import ./send-mail.nix { inherit pkgs; });
      packages.x86_64-linux.default = self.packages.x86_64-linux.send-mail;
    };
}
