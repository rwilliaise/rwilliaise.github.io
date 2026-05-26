{
  pkgs ? import <nixpkgs> {}
}:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    jekyll
    rubyPackages.jekyll-paginate
  ];
}
