local M = {}

M.load_mappings = function()

	vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
	vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
	vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
	vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "switch window right" })

	vim.keymap.set("n", "<leader>n", "<cmd>set relativenumber!<CR>", { desc = "toggle relative line number" })

	-- nvimtree
	vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
	vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

	-- telescope
	vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
	vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
	vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
	vim.keymap.set("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
	vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
	vim.keymap.set("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
	vim.keymap.set("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
	vim.keymap.set("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
	vim.keymap.set("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
	vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
	vim.keymap.set(
		"n",
		"<leader>fa",
		"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
		{ desc = "telescope find all files" }
	)


	vim.keymap.set({'n', 'x'}, 'gy', '"+y')
	vim.keymap.set({'n', 'x'}, 'gp', '"+p')
end

return M
