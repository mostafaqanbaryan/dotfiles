return {
	cmd = { "vtsls", "--stdio" },
	root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
}
