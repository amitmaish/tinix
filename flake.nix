{
  description = "more nix stuffs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./indestructabletype.nix
        ./tom7fonts
        inputs.flake-parts.flakeModules.easyOverlay
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        overlayAttrs = {
          tinix-fonts = (config.packages).fonts;
        };
        packages.fonts = pkgs.buildEnv {
          name = "tinix";
          paths = with config.packages; [
            indestructable-type
            tom7-fonts
          ];
        };
      };
    };
}
