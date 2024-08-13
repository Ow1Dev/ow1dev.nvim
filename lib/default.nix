{inputs}: let
  inherit (inputs.nixpkgs) legacyPackages;
in rec {
  mkVimPlugin = {system}: let
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

  mkNeovimPlugins = {system}: let
    inherit (pkgs) vimPlugins;
    pkgs = legacyPackages.${system};
    Ow1Dev-nvim = mkVimPlugin {inherit system;};
  in [
    # languages
    vimPlugins.nvim-lspconfig
    vimPlugins.nvim-treesitter.withAllGrammars
    vimPlugins.none-ls-nvim

    #Snippets
    vimPlugins.luasnip
    vimPlugins.cmp_luasnip
    vimPlugins.friendly-snippets

    # Autocompletion
    vimPlugins.nvim-cmp
    vimPlugins.cmp-buffer
    vimPlugins.cmp-path
    vimPlugins.cmp-nvim-lsp
    vimPlugins.cmp-nvim-lua
    vimPlugins.cmp-emoji
    vimPlugins.nvim-autopairs

    # telescope
    vimPlugins.plenary-nvim
    vimPlugins.popup-nvim
    vimPlugins.telescope-nvim
    vimPlugins.telescope-fzf-native-nvim

    # theme
    vimPlugins.catppuccin-nvim
    vimPlugins.lualine-nvim
    vimPlugins.nvim-notify
    vimPlugins.noice-nvim

    # extra
    vimPlugins.neogit
    vimPlugins.oil-nvim
    vimPlugins.gitsigns-nvim

    # configuration
    Ow1Dev-nvim
  ];

  mkExtraPackages = {system}: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    nodePackages = pkgs.nodePackages;
  in [
    # language servers
    pkgs.lua-language-server
    pkgs.nil
    pkgs.rust-analyzer
    pkgs.yaml-language-server
    nodePackages.typescript-language-server

    # formatters
    pkgs.alejandra
    pkgs.stylua

    # extra
    pkgs.fzf
    pkgs.ripgrep
  ];

  mkExtraConfig = ''
    lua << EOF
      require 'Ow1Dev'.init()
    EOF
  '';

  mkNeovim = {system}: let
    inherit (pkgs) lib neovim;
    pkgs = legacyPackages.${system};
    extraPackages = mkExtraPackages {inherit system;};
    start = mkNeovimPlugins {inherit system;};
  in
    neovim.override {
      configure = {
        customRC = mkExtraConfig;
        packages.main = {inherit start;};
      };
      extraMakeWrapperArgs = ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
    };

  mkHomeManager = {system, package}: let
    extraConfig = mkExtraConfig;
    extraPackages = mkExtraPackages {inherit system;};
    plugins = mkNeovimPlugins {inherit system;};
  in {
    inherit extraConfig extraPackages plugins;
    defaultEditor = true;
    enable = true;
    package = package;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
