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
    packages.ukmm-bin = pkgs.callPackage ({
      fetchzip,
      lib,
      stdenv,
      undmg,
    }: let
      pname = "ukmm-bin";
      version = "0.17.0";
      meta = {
        inherit (pkgs.ukmm.meta) license homepage description mainProgram longDescription;
        platforms = [
          "aarch64-darwin"
        ];
      };
    in
      stdenv.mkDerivation rec {
        inherit pname version meta;

        src = fetchzip {
          url = "https://github.com/NiceneNerd/ukmm/releases/download/v${version}/ukmm-aarch64-apple-darwin.tar.xz";
          hash = "sha256-VMFqW+ySkhV73KW6srWtsQx06oqcHUeAo8PkfU2xyIE=";
        };
        dontBuild = true;
        dontStrip = true;

        nativeBuildInputs = [
          undmg
        ];

        installPhase = ''
          runHook preInstall
          mkdir -p "$out/bin"
          cp ukmm "$out/bin/ukmm"
          runHook postInstall
        '';
      }) {};
  };
}
