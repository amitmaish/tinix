{
  perSystem = {
    pkgs,
    config,
    ...
  }: {
    packages._8bitdo_ultimate_v2 = pkgs.callPackage ({
      fetchzip,
      lib,
      stdenv,
      undmg,
    }: let
      pname = "8bitdo_ultimate_v2";
      version = "1.0.17";
      meta = {
        platforms = lib.platforms.darwin;
      };
    in
      stdenv.mkDerivation rec {
        inherit pname version meta;

        src = fetchzip {
          url = "https://support.8bitdo.com/upfiles/Ultimate-Software-V2/8BitDo_Ultimate_Software_V2_macOS_V${version}.zip";
          hash = "sha256-E7Wqnz9u44W67osVWtmX0qOtEku/kah7kx557/AnfrQ=";
        };

        installPhase = ''
          runHook preInstall
          mkdir -p "$out/Applications/8BitDo Ultimate Software V2.app"
          cp -r * "$out/Applications/8BitDo Ultimate Software V2.app/"
          runHook postInstall
        '';
      }) {};
  };
}
