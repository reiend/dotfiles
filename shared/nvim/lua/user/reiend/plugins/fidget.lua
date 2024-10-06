return {
  "j-hui/fidget.nvim",
  tag = "v1.0.0",
  priority = 1000,
  config = function()
    require("fidget").setup {
      progress = {
        display = {
          render_limit = 1
        }
      },
      notification = {
        window = {
          winblend = 0
        }
      }
    }
  end
}
