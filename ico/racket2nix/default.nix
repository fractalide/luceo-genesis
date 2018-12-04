let
  bootPkgs = import <nixpkgs> {};
  pinnedPkgs = bootPkgs.fetchFromGitHub {
    owner = "fractalide";
    repo = "racket2nix";
    rev = "df7d4d4500d0326d47a9f6831f1eef3800a78eae";
    sha256 = "0rr3y8glljdr7zirl5zjgy8i6pnq24lxyb6w0k2465wdfk4gc11b";
  };
in
import pinnedPkgs
