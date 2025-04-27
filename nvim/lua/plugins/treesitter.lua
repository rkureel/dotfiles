return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = {
			"BufReadPost", "BufNewFile"
		},
		cmd = {
			"TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo"
		},
		build = ":TSUpdate",
		opts = {
			ensure_installed = { 
				"lua", "luadoc", "printf", "vim", "vimdoc" , "java",
				"json", "typescript", "python", "go", "rust"
			},
			highlight = {
				enable = true,
				use_languagetree = true,
			},
			indent = { enable = true }
		}
	}
}
