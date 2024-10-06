return function(lsp_config)
  return function()
    lsp_config.clangd.setup {
      cmd = { 'clangd'},
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
      single_file_support = true,
    }
  end
end
