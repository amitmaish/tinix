{
  description = "more nix stuffs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    bevy_cli = {
      url = "github:TheBevyFlock/bevy_cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./8bitdo.nix
        ./blender.nix
        ./emulator.nix
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
          inherit
            (config.packages)
            azahar-bin
            _8bitdo_ultimate_v2
            blender-bin
            cemu-bin
            ukmm-bin
            ;
          tinix-fonts = (config.packages).fonts;
          bevy = (config.packages).bevy;
        };
        packages.fonts = pkgs.buildEnv {
          name = "tinix";
          paths = with config.packages; [
            indestructable-type
            tom7-fonts
          ];
        };
        packages.bevy = inputs.bevy_cli.packages.${system}.default;
      };
    };
}
