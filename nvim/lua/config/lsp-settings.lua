local options = {
	diagnostics = {
		underline = true,
		update_in_insert = false,
		virtual_text = {
			spacing = 4,
			source = "if_many",
			prefix = "●",
		},
		virtual_lines = true,
		severity_sort = true,
	},

	inlay_hints = {
		enabled = true,
	},

	codelens = {
		enabled = true,
	},

	capabilities = {
		workspace = {
			fileOperations = {
				didRename = true,
				willRename = true,
			},
		},
	},

	format = {
		format = {
			formatting_options = nil,
			timeout_ms = nil,
		},
	},

	servers = {
		lua_ls = {
			-- mason = false, -- set to false if you don't want this server to be installed with mason
			-- Use this to add any additional keymaps
			-- for specific lsp servers
			-- ---@type LazyKeysSpec[]
			-- keys = {},
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
					},
					codeLens = {
						enable = true,
					},
					completion = {
						callSnippet = "Replace",
					},
					doc = {
						privateName = { "^_" },
					},
					hint = {
						enable = true,
						setType = false,
						paramType = true,
						paramName = "Disable",
						semicolon = "Disable",
						arrayIndex = "Disable",
					},
				},
			},
		},
	},

	setup = {},
}

local configure_lsp = function(opts)
	-- configure diagnostics
	vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
end

local on_attach = function(client, bufnr)
	local buf_opts = { buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, buf_opts, "Go to declaration")
	vim.keymap.set("n", "gd", vim.lsp.buf.declaration, buf_opts, "Go to definition")
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, buf_opts, "Add workspace folder")
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, buf_opts, "Remove workspace folder")
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, buf_opts, "List workspace folders")
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, buf_opts, "Go to type definition")
end

return {
	opts = options,
	config = configure_lsp,
	on_attach = on_attach,
}

