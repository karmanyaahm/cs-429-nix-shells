{
  description = "Scratch dir for various testing";

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        gcc8
python311Packages.tabulate	
gdb
      ];
    };
  };
}
