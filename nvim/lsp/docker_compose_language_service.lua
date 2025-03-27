return {
	cmd = { "docker-compose-langserver", "--stdio" },
	root_markers = {
		"docker-compose.yaml",
		"docker-compose.yml",
		"compose.yaml",
		"compose.yml",
	},
	filetypes = {
		"yaml.docker-compose",
	},
}
