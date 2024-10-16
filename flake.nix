{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    nixpkgs,
    utils,
    ...
  }:
    utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        devShells.default = pkgs.mkShell {
          nativebuildInputs = with pkgs; [
            pkg-config
          ];
          buildInputs = with pkgs; [
            libiconv
            darwin.apple_sdk.frameworks.CoreWLAN
          ];
        };
      }
    );
}
