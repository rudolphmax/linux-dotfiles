return {
  "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "c",
        "go"
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
