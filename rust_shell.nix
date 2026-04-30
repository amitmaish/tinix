{
  perSystem = {
    config,
    inputs',
    pkgs,
    system,
    ...
  }: {
    devShells.rust-shell = pkgs.mkShell {
      buildInputs = with pkgs; [
        rust-bin.stable.latest.default
        rust-bin.stable.latest.rust-analyzer
      ];
    };
  };
}
