{ inputs }:
let
  inherit (inputs.nixpkgs) legacyPackages;
in
rec {
  mkVimPlugin = { system }:
    let
      inherit (pkgs) vimUtils;
      inherit (vimUtils) buildVimPlugin;
      pkgs = legacyPackages.${system};
    in
    buildVimPlugin {
      name = "Ow1Dev";
      postInstall = ''
        rm -rf $out/.envrc
        rm -rf $out/.gitignore
        rm -rf $out/LICENSE
        rm -rf $out/README.md
        rm -rf $out/flake.lock
        rm -rf $out/flake.nix
        rm -rf $out/justfile
        rm -rf $out/lib
      '';
      src = ../.;
    };

  mkNeovimPlugins = { system }:
    let
      inherit (pkgs) vimPlugins;
      pkgs = legacyPackages.${system};
      Ow1Dev-nvim = mkVimPlugin { inherit system; };
    in
    [
      # languages
      vimPlugins.nvim-lspconfig
      vimPlugins.nvim-treesitter.withAllGrammars

      # telescope
      vimPlugins.plenary-nvim
      vimPlugins.popup-nvim
      vimPlugins.telescope-nvim
      vimPlugins.telescope-fzf-native-nvim

      # theme
      vimPlugins.catppuccin-nvim

      # configuration
      Ow1Dev-nvim
    ];

  mkExtraPackages = {system}: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in [
      pkgs.fzf
  ];

  mkExtraConfig = ''
    lua << EOF
      require 'Ow1Dev'.init()
    EOF
  '';

  mkNeovim = { system }:
    let
      inherit (pkgs) lib neovim;
      extraPackages = mkExtraPackages {inherit system;};
      pkgs = legacyPackages.${system};
      start = mkNeovimPlugins { inherit system; };
    in
    neovim.override {
      configure = {
        customRC = mkExtraConfig;
        packages.main = { inherit start; };
      };
      extraMakeWrapperArgs = ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
    };
}
