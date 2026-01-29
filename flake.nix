{
  description = "more nix stuffs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        packages.fonts = pkgs.buildEnv {
          name = "tinix";
          paths = with config.packages; [
            notears
          ];
        };
        packages.notears = pkgs.stdenvNoCC.mkDerivation {
          name = "no-tears*-font";
          dontConfigure = true;
          src = pkgs.fetchzip {
            url = "https://indestructibletype.com/notears.zip";
            sha256 = "sha256-M9WHCW5i5HlW1Bkg4Dd7raK4i8KHvO5wKJnezYnN4YQ=";
            stripRoot = false;
          };
          installPhase = ''
            mkdir -p $out/share/fonts
            cp -R $src $out/share/fonts/truetype/
          '';
          meta = {description = "it's like Comic Sans but with justification";};
        };
      };
    };
}
