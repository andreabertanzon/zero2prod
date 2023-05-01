{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { nixpkgs, rust-overlay, ... }: let
    system = "aarch64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (final: prev: {
          rust-overlay = rust-overlay.packages.${prev.system}.default;
        })
      ];
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = builtins.attrValues {
        inherit (pkgs) gcc rust-overlay;
      };
     
      shellHook = ''
        fish
      '';
    };
  };
}
