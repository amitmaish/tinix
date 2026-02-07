{
  perSystem = {
    pkgs,
    config,
    ...
  }: {
    packages.indestructable-type = pkgs.buildEnv {
      name = "indestructible-type*";
      paths = with config.packages; [
        gnomon
        marauder
        notears
      ];
      meta = {description = "fonts from indestructible type*";};
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

    packages.marauder = pkgs.stdenvNoCC.mkDerivation {
      name = "marauder*-font";
      dontConfigure = true;
      src = pkgs.fetchzip {
        url = "https://indestructibletype.com/Marauder.zip";
        sha256 = "sha256-wVaZLfEl/+LI+OqbtxiVdcYjrWfKTu7KdXeTXMI9TjM=";
        stripRoot = false;
      };
      installPhase = ''
        mkdir -p $out/share/fonts
        cp -R $src/ttf $out/share/fonts/truetype/
        cp -R $src/otf $out/share/fonts/opentype/
      '';
    };

    packages.gnomon = pkgs.stdenvNoCC.mkDerivation {
      name = "gnomon*-font";
      dontConfigure = true;
      src = pkgs.fetchFromGitHub {
        owner = "indestructible-type";
        repo = "Gnomon";
        rev = "7517c82";
        hash = "sha256-7+4N2XFRfZ5tZnECQPcuejq4ZPGoVsIWF8u+85TGURk=";
      };

      nativeBuildInputs = with pkgs; [
        python313Packages.fontmake
      ];

      buildPhase = ''
        cd $src/Source/Gnomon\*\ Simple

        mkdir -p $out/share/fonts/truetype
        fontmake -o variable -m gnomon.designspace --output-dir $out/share/fonts/truetype
      '';
    };
  };
}
