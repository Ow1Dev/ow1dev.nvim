#### Run in shell

- Run `neovim` directly with:

```shell
$ nix run github:ALT-F4-LLC/ow1dev.nvim#neovim
```

- Run `neovim` in new shell with:

```shell
$ nix shell github:ALT-F4-LLC/ow1dev.nvim#neovim
$ neovim
```

#### Add to flake

- Add to `flake.nix` as an input:

```nix
inputs = {
  ow1dev.url = "github:Ow1Dev/ow1dev.nvim";
};
```

- (option a): Add to `environment.systemPackages` configuration:

```nix
environment.systemPackages = [
  inputs.ow1dev.packages.${pkgs.system}.neovim
];
```

- (option b): Add to `home-manager` configuration:

```nix
programs.neovim = inputs.ow1dev-nvim.lib.mkHomeManager {
  system = pkgs.system;
};
```
