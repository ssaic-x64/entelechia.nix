# Default Nix expression for Entelechia
# Provides backward compatibility for non-flake users

{ pkgs ? import <nixpkgs> {} }:

let
  # Import the library
  entelechiaLib = import ./lib/entelechia.nix { inherit pkgs; };

in pkgs.stdenv.mkDerivation {
  pname = "entelechia";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib
    mkdir -p $out/share/entelechia/modes
    mkdir -p $out/share/entelechia/examples

    # Install library
    cp lib/entelechia.nix $out/lib/

    # Install agent script
    cp bin/entelechia $out/bin/
    chmod +x $out/bin/entelechia

    # Wrap the script with NIX_PATH
    wrapProgram $out/bin/entelechia \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.nix pkgs.jq pkgs.coreutils ]} \
      --set ENTELECHIA_LIB $out/lib/entelechia.nix

    # Install examples
    cp -r examples/* $out/share/entelechia/examples/
  '';

  meta = with pkgs.lib; {
    description = "A declarative philosopher-agent system for reflective reasoning";
    homepage = "https://github.com/ssaic-x64/entelechia.nix";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = [];
  };
}
