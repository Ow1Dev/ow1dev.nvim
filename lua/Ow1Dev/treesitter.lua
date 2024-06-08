local function init()
	local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
	vim.fn.mkdir(parser_install_dir, "p")
	vim.opt.runtimepath:append(parser_install_dir)

	require("nvim-treesitter.configs").setup({
		ensure_installed = { "lua", "bash" }, -- put the language you want in this array
		parser_install_dir = parser_install_dir,
		highlight = { enable = true },
		indent = { enable = true },
	})
end

return {
	init = init,
}
