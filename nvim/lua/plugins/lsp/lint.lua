return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			php = { "phpstan" },
		}
		local phpstan = require("lint").linters.phpstan
		phpstan.args = {
			"analyze",
			"--error-format=json",
			"--no-progress",
			"--memory-limit=2G",
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				if vim.bo.filetype == "php" then
					-- If project exists in a subdirectory, we have to go to the subdirectory and run linter
					local dirs = { "backend", "html", "app", "." }
					for i, x in pairs(dirs) do
						local f = io.open(x .. "/phpstan.neon", "r")
						if f ~= nil then
							f.close()
							vim.cmd("cd " .. x)
							lint.try_lint()
							vim.cmd("cd ..")
							break
						end
					end
				else
					lint.try_lint()
				end
			end,
		})
	end,
}
