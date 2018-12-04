{ racket2nix ? import ./racket2nix {}
}:

let inherit (racket2nix) buildRacketPackage; in

buildRacketPackage ./.
