return {
	settings = {
		gopls = {
			-- Disable semantic tokens - use treesitter highlighting instead
			semanticTokens = false,
			-- Enable useful analyses
			analyses = {
				unusedparams = true,
				shadow = false,
				unusedvariable = true,
				useany = false,
			},
			-- Keep staticcheck enabled for better highlighting
			staticcheck = true,
			-- Enable inlay hints for better code understanding
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			-- Enable gofumpt for formatting (stricter than gofmt)
			gofumpt = true,
		},
	},
}
