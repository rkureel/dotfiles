return {
	{
		"neovim/nvim-lspconfig",
		-- event = "User FilePost",
		dependencies = {
			{
				"mason.nvim"
			},
			{
				"williamboman/mason-lspconfig.nvim",
				config = function()
				end
			},
		},
		opts = function()
			return require("config.lsp-settings").opts
		end,

		config = function(_, opts)
			require("config.lsp-settings").config(opts)

			local servers = opts.servers
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities() or {},
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				opts.capabilities or {}
			)

			local function setup(server)
				local on_attach = require("config.lsp-settings").on_attach
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
					on_attach = on_attach,
				}, servers[server] or {})
				if server_opts.enabled == false then
					return
				end

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end

				require("lspconfig")[server].setup(server_opts)
			end


			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					if server_opts.enabled ~= false then
						setup(server)
					end
				end
			end
		end
	}
}
