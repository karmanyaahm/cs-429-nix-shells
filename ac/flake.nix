{
  description = "Scratch dir for various testing";

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
nixarm = import <nixpkgs> {
  crossSystem = {
    config = "aarch64-unknown-linux-gnu";
  };

};

    # this will use aarch64 binaries from binary cache, so no need to build those
    pkgsArm = import <nixpkgs> {
        config = {};
        overlays = [];
        system = "aarch64-linux";
    };

    # these will be your cross packages
    pkgsCross = import <nixpkgs> {

       overlays = [(self: super: {

         # we want to hack on SDL, don't want to hack on those. Some even don't cross-compile
        # inherit (pkgsArm)
        #   xorg libpulseaudio libGL guile systemd libxkbcommon
        # ;
 
       })];
       crossSystem = {
         config = "aarch64-unknown-linux-gnu";
       };
     };

  in {
    devShells.${system}.default = pkgs.mkShell {
      packages =  [
pkgs.qemu
pkgsArm.gdb
pkgsArm.gef
#pkgs.gcc-arm-embedded
pkgsArm.gcc
];
    };
  };
}
