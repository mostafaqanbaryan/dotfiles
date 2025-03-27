return {
	cmd = { "gopls" },
	root_markers = { "go.mod", "go.sum" },
	filetypes = { "go" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
				nilness = true,
				unusedwrite = true,
				useany = true,
			},
			staticcheck = true, -- Enable staticcheck
			codelenses = {
				generate = true,
				gc_details = true,
				test = true,
			},
			hints = {
				assignVariableTypes = false,
				compositeLiteralFields = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
}
