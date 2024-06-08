local function keymaps()
    local options = { noremap = true, silent = true }
    vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", options)
end

local function init()
  require("oil").setup {
    default_file_explorer = false,
    float = {
      max_height = 20,
      max_width = 60,
    },
  }
  keymaps()
end

return {
	init = init,
}

