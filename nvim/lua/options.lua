local M = {}

M.set_options = function()
	vim.g.mapleader = ","
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	vim.opt.relativenumber = true
	vim.opt.number = true
	vim.opt.mouse = 'a' 
	vim.opt.ignorecase = true
	vim.opt.smartcase = true
	vim.opt.hlsearch = false
	vim.opt.wrap = true
	vim.opt.breakindent = true
	vim.opt.tabstop = 4
	vim.opt.shiftwidth = 4
	vim.opt.expandtab = false
	vim.opt.termguicolors = true
end

return M
