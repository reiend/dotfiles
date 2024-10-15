{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
    };
    neovim = {
      enable = true;
      package = pkgs.unstable.neovim-unwrapped;
      plugins = with pkgs.vimPlugins; [
        catppuccin-nvim
        (nvim-treesitter.withPlugins (p: [
          p.lua
          p.nix
          p.cmake
        ]))
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-cmdline
        cmp-path
        luasnip
        cmp_luasnip
        telescope-nvim
        lualine-nvim
        fidget-nvim
        gitsigns-nvim
        nvim-tree-lua
        transparent-nvim
        indent-blankline-nvim
        conform-nvim
        nvim-lint
        comment-nvim
        nvim-web-devicons
      ];
      extraLuaConfig =
        let
          root = ./../../../../../../shared/nvim/lua/user/reiend;
          keymaps = builtins.readFile (root + /keymaps/init.lua);
          options = builtins.readFile (root + /options/init.lua);
          setupPlugin = plugin: ''
            local plugin = function () ${builtins.readFile (root + /plugins/${plugin}.lua)} end
            plugin().config()
          '';
          setupLsp = lsp: ''
            local lsp = (function () ${builtins.readFile (root + /lsp/${lsp}.lua)} end)()
            lsp.capabilities = capabilities
            local lspconfig = require 'lspconfig'
            lspconfig.${lsp}.setup(lsp)
          '';
        in
        ''
          ${keymaps}
          ${options}
          ${setupPlugin "catppuccin"}
          ${setupPlugin "nvim_cmp"}
          ${setupPlugin "telescope"}
          ${setupPlugin "lualine"}
          ${setupPlugin "fidget"}
          ${setupPlugin "gitsigns"}
          ${setupPlugin "nvim_tree"}
          ${setupPlugin "transparent"}
          ${setupPlugin "comment"}
          ${setupPlugin "indent_blankline"}
          ${setupPlugin "nvim_lspconfig"}
          ${setupPlugin "conform"}
          ${setupPlugin "nvim_lint"}

          ${setupLsp "lua_ls"}
          ${setupLsp "clangd"}
          ${setupLsp "tsserver"}
          ${setupLsp "nil_ls"}
        '';
    };
  };
}
