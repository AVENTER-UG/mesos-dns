with import <nixpkgs> {};


stdenv.mkDerivation {
  name = "mesos-dns";

  buildInputs = [
    go
  ];

  shellHook = ''
    cp ./config.json.sample /data/config.json
  '';
}
