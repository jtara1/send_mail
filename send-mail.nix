{
  pkgs ? import <nixpkgs> { },
}:
with pkgs;
stdenv.mkDerivation {
  pname = "send-mail";
  version = "1.0";
  meta = {
    description = "simple command-line for sending an email with remote auth";
    maintainers = [ "jtara1" ];
    license = lib.licenses.asl20;
  };

  src = ./send_mail.py;
  buildInputs = [ python3 ];
  dontUnpack = true;
  postInstall = ''
    mkdir -p $out/bin
    cp $src $out/bin/send-mail
    chmod +x $out/bin/send-mail
  '';
}
