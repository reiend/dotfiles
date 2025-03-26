local lspconfig = (require 'lspconfig')

return {
  cmd = { 'nil' },
  single_file_support = true,
  root_dir = lspconfig.util.root_pattern('flake.lock', '.git'),
  filetypes = { 'nix' },
}
