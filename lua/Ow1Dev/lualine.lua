local diagnostics = {
	"diagnostics",
	sections = { "error", "warn" },
	colored = false, -- Displays diagnostics status in color if set to true.
	always_visible = true, -- Show diagnostics even if there are none.
}

local function init()
	require("lualine").setup({
		options = {
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },

			ignore_focus = { "NvimTree" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = { diagnostics },
			lualine_y = { "progress" },
			lualine_z = {},
		},
		-- extensions = { "quickfix", "man", "fugitive", "oil" },
		extensions = { "quickfix", "man", "fugitive" },
	})
end

return {
	init = init,
}
