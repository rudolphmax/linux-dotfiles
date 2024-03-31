return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = { add = { text = "│" }, change = { text = "│" } },
    current_line_blame = true,
    current_line_blame_opts = { delay = updatetime },
    sign_priority = 1,
    update_debounce = updatetime,
    preview_config = { border = "rounded", row = 1, col = 0 },
  }
}
