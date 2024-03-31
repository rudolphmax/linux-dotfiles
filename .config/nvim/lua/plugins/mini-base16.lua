return {
  'echasnovski/mini.base16',
  version = false,
  config = function()
    require('mini.base16').setup({
      palette = {
        -- start flavours
base00 = "#f1efee",
base01 = "#e6e2e0",
base02 = "#a8a19f",
base03 = "#9c9491",
base04 = "#766e6b",
base05 = "#68615e",
base06 = "#2c2421",
base07 = "#1b1918",
base08 = "#f22c40",
base09 = "#df5320",
base0A = "#c38418",
base0B = "#7b9726",
base0C = "#3d97b8",
base0D = "#407ee7",
base0E = "#6666ea",
base0F = "#c33ff3"
        -- end flavours
      }
    })
  end
}
