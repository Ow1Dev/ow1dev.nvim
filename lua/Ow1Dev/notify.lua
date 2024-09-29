local notify = require("notify")

local function init()
	notify.setup({
		render = "wrapped-compact",
		timeout = 2500,
    stages = 'static',
	})
end

return {
	init = init,
}
