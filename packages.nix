let
  nixpkgs = builtins.getFlake "github:nixos/nixpkgs/nixpkgs-unstable";
  nixpkgs-review = builtins.getFlake "github:Mic92/nixpkgs-review/d9ab24795df1bf1d8374d3f9606f3416596b821b";
in

import nixpkgs {
  overlays = [
    (final: prev: {
      inherit (nixpkgs-review.packages.${final.system}) nixpkgs-review;

      generate-markdown-report = final.writers.writePython3Bin "generate-markdown-report" {
        flakeIgnore = [
          "E501" # line too long
        ];
      } (builtins.readFile ./generate_markdown_report.py);
    })
  ];
}
