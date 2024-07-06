-- An always-on highlight for a unique character in every word on a line to help you use f, F and family.
return {
	'unblevable/quick-scope',
	keys = { 'f', 'F', 't', 'T' },
	init = function()
		vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
	end
};
