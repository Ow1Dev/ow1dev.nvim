local function init()
    require 'Ow1Dev.options'.init()
    require 'Ow1Dev.keymaps'.init()
    require 'Ow1Dev.telescope'.init()
    require 'Ow1Dev.treesitter'.init()
end

return {
    init = init,
}
