return {
	"olimorris/codecompanion.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "openai_compatible",
				},
				inline = {
					adapter = "openai_compatible",
				},
			},
			http = {
				adapters = {
					openai_compatible = function()
						return require("codecompanion.adapters").extend("openai", {
							schema = {
								model = {
									default = "gpt-4o",
								},
							},
						})
					end,
				},
			},
		})

		local function keymapOptions(desc)
			return {
				noremap = true,
				silent = true,
				nowait = true,
				desc = "CodeCompanion " .. desc,
			}
		end

		vim.keymap.set("n", "<leader>g", "<cmd>CodeCompanionChat Toggle<CR>", keymapOptions("Toggle Chat"))
		vim.keymap.set(
			"v",
			"<leader>g",
			"<cmd>CodeCompanionChat Add<CR>",
			keymapOptions("Toggle Chat and Add Selected Range")
		)
	end,
}
