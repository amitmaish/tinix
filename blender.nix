{
  perSystem = {
    pkgs,
    config,
    ...
  }: {
    packages.blender-bin = pkgs.callPackage ({
      fetchurl,
      lib,
      stdenv,
      undmg,
    }: let
      pname = "blender-bin";
      version = "5.1.2";
      meta = {
        inherit (pkgs.blender.meta) license homepage description mainProgram longDescription;
        platforms = [
          "aarch64-darwin"
        ];
      };
    in
      stdenv.mkDerivation rec {
        inherit pname version meta;

        src = fetchurl {
          url = "https://mirrors.iu13.net/blender/release/Blender5.1/blender-${version}-macos-arm64.dmg";
          hash = "sha256-8QT/7iumruMjKOXCA7fkYI2KF0X3u88nZvO5d36Pvhc=";
        };
        dontBuild = true;
        dontStrip = true;

        nativeBuildInputs = [
          undmg
        ];
        sourceRoot = "Blender.app";

        installPhase = ''
          runHook preInstall
          mkdir -p "$out/Applications/Blender.app"
          cp -r * "$out/Applications/Blender.app/"
          runHook postInstall
        '';
      }) {};
  };
}
