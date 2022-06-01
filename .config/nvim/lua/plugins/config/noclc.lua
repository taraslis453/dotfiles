local status_ok, no_clc = pcall(require, "no-clc")
if not status_ok then
	return
end

local setup = {
	load_at_startup = true,
	cursorline = true,
}

no_clc.setup(setup)
