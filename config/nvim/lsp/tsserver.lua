local lspconfig = (require 'lspconfig')

return {
  cmd = { 'typescript-language-server', '--stdio' },
  single_file_support = true,
  root_dir = lspconfig.util.root_pattern(
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    '.git'
  ),
  filetypes = {
    'javascript',
    'typescript',
    'vue',
  },
}
