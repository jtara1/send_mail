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
      packages.x86_64-linux.send-mail = pkgs.stdenv.mkDerivation {
        pname = "send-mail";
        version = "1.0";
        src = ./send_mail.py;

        buildInputs = [ pkgs.python3 ];

        dontUnpack = true;
        postInstall = ''
          mkdir -p $out/bin
          cp $src $out/bin/send-mail
          chmod +x $out/bin/send-mail
        '';
      };

      packages.x86_64-linux.default = self.packages.x86_64-linux.send-mail;
    };
}
