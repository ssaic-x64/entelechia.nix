{
  description = "Entelechia - A declarative philosopher-agent system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # Philosophy agent library
        entelechiaLib = pkgs.writeTextFile {
          name = "entelechia-lib";
          destination = "/lib/entelechia.nix";
          text = builtins.readFile ./lib/entelechia.nix;
        };

        # Main entelechia package
        entelechia = pkgs.stdenv.mkDerivation {
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

            # Install modes
            if [ -d modes ]; then
              cp -r modes/* $out/share/entelechia/modes/
            fi

            # Install examples
            if [ -d examples ]; then
              cp -r examples/* $out/share/entelechia/examples/
            fi
          '';

          meta = with pkgs.lib; {
            description = "A declarative philosopher-agent system for reflective reasoning";
            homepage = "https://github.com/ssaic-x64/entelechia.nix";
            license = licenses.mit;
            platforms = platforms.unix;
          };
        };

      in {
        packages = {
          default = entelechia;
          entelechia = entelechia;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nix
            jq
            coreutils
            nixpkgs-fmt
          ];

          shellHook = ''
            echo "Entelechia Development Environment"
            echo "=================================="
            echo "A declarative philosopher-agent system"
            echo ""
            echo "Available commands:"
            echo "  nix build         - Build the entelechia package"
            echo "  nix run           - Run the entelechia agent"
            echo "  nix develop       - Enter development shell"
            echo ""
          '';
        };

        apps.default = {
          type = "app";
          program = "${entelechia}/bin/entelechia";
        };
      }
    );
}
