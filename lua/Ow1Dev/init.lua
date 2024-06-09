local function init()
    require 'Ow1Dev.options'.init()
    require 'Ow1Dev.keymaps'.init()
    require 'Ow1Dev.lualine'.init()
    require 'Ow1Dev.telescope'.init()
    require 'Ow1Dev.treesitter'.init()
    require 'Ow1Dev.lspconfig'.init()
    require 'Ow1Dev.null-ls'.init()
    require 'Ow1Dev.cmp'.init()
    require 'Ow1Dev.neogit'.init()
    require 'Ow1Dev.oil'.init()
    require 'Ow1Dev.notify'.init()
    require 'Ow1Dev.noice'.init()
end

return {
    init = init,
}
