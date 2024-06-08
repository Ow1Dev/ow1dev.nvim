local function init()
    require 'Ow1Dev.options'.init()
    require 'Ow1Dev.keymaps'.init()
    require 'Ow1Dev.telescope'.init()
end

return {
    init = init,
}
