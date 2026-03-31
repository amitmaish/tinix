{
  perSystem = {
    pkgs,
    config,
    ...
  }: {
    packages.cemu-bin = pkgs.callPackage ({
      fetchurl,
      lib,
      stdenv,
      undmg,
    }: let
      pname = "cemu-bin";
      version = "2.6";
      meta = {
        inherit (pkgs.cemu.meta) license homepage description mainProgram longDescription;
        platforms = [
          "aarch64-darwin"
        ];
      };
    in
      stdenv.mkDerivation rec {
        inherit pname version meta;

        src = fetchurl {
          url = "https://github.com/cemu-project/Cemu/releases/download/v${version}/cemu-${version}-macos-12-x64.dmg";
          hash = "sha256-aYxLKY+UmD5NbDDpaHuo/wUJTdOTCDfFEEzdwLCknk4=";
        };
        dontBuild = true;
        dontStrip = true;

        nativeBuildInputs = [
          undmg
        ];
        sourceRoot = "cemu.app";

        installPhase = ''
          runHook preInstall
          mkdir -p "$out/Applications/cemu.app"
          cp -r * "$out/Applications/cemu.app/"
          runHook postInstall
        '';
      }) {};
  };
}
