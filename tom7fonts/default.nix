{
  perSystem = {
    pkgs,
    config,
    ...
  }: {
    packages.tom7-fonts = pkgs.buildEnv {
      name = "tom 7 fonts";
      paths = with config.packages; [
        upperercase
        comicsands
        futurda
        heavenica
        spezial-hellvetica
        expnewroman
        plusnewroman
        perfect-hallucination
      ];
      meta = {description = "fonts by tom 7";};
    };

    packages.upperercase = pkgs.stdenvNoCC.mkDerivation {
      name = "upperercase";
      dontConfigure = true;
      dontUnpack = true;
      src = ./upperercase.ttf;
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp -R $src $out/share/fonts/truetype/
      '';
    };

    packages.comicsands = pkgs.stdenvNoCC.mkDerivation {
      name = "comicsands";
      dontConfigure = true;
      dontUnpack = true;
      src = ./comicsands.ttf;
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp -R $src $out/share/fonts/truetype/
      '';
    };

    packages.futurda = pkgs.stdenvNoCC.mkDerivation {
      name = "futurda";
      dontConfigure = true;
      dontUnpack = true;
      src = ./futurda.ttf;
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp -R $src $out/share/fonts/truetype/
      '';
    };

    packages.heavenica = pkgs.stdenvNoCC.mkDerivation {
      name = "heavenica";
      dontConfigure = true;
      dontUnpack = true;
      src = ./heavenica.ttf;
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp -R $src $out/share/fonts/truetype/
      '';
    };

    packages.spezial-hellvetica = pkgs.stdenvNoCC.mkDerivation {
      name = "spezial hellvetica";
      dontConfigure = true;
      dontUnpack = true;
      src = ./spezial-hellvetica.ttf;
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp -R $src $out/share/fonts/truetype/
      '';
    };

    packages.expnewroman = pkgs.stdenvNoCC.mkDerivation {
      name = "exponential new roman";
      dontConfigure = true;
      dontUnpack = true;
      src = ./expnewroman.ttf;
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp -R $src $out/share/fonts/truetype/
      '';
    };

    packages.plusnewroman = pkgs.stdenvNoCC.mkDerivation {
      name = "plus new roman";
      dontConfigure = true;
      dontUnpack = true;
      src = ./plusnewroman.ttf;
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp -R $src $out/share/fonts/truetype/
      '';
    };

    packages.perfect-hallucination = pkgs.stdenvNoCC.mkDerivation {
      name = "perfect hallucination";
      dontConfigure = true;
      dontUnpack = true;
      src = ./hallucination.ttf;
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp -R $src $out/share/fonts/truetype/
      '';
    };
  };
}
