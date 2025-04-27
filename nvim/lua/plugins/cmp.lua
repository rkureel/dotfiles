return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			{				
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
			},
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)

					-- setup cmp for autopairs
					local cmp_autopairs = require "nvim-autopairs.completion.cmp"
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
		},
		opts = function()
			local cmp = require("cmp")
			local options = {
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "nvim_lua" },
					{ name = "path" },
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				completion = {
					completeopts = "menu,menuone,noselect"
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),

					["<CR>"] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					},
				},
			}
			return options
		end,

		config = function(_, opts)
			local cmp = require("cmp")
			cmp.setup({
				snippet = opts.snippet,
				mapping = opts.mapping,
				sources = opts.sources,
				completion = opts.completion,
			})
			
			cmp.setup.cmdline(":", {
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				})
			})
		end
	}
}
