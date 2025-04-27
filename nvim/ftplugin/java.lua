local root_patterns = {
	".git",
	"pom.xml",
	"build.gradle.kts",
}

local get_jdtls_paths = function()
	local path = {}

	path.data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'

	local jdtls_install = require('mason-registry')
	.get_package('jdtls')
	:get_install_path()

	path.java_agent = jdtls_install .. '/lombok.jar'
	path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

	if vim.fn.has('mac') == 1 then
		path.platform_config = jdtls_install .. '/config_mac'
	elseif vim.fn.has('unix') == 1 then
		path.platform_config = jdtls_install .. '/config_linux'
	elseif vim.fn.has('win32') == 1 then
		path.platform_config = jdtls_install .. '/config_win'
	end

	path.data_dir =  vim.fn.stdpath("cache") .. "/nvim-jdtls"

	return path
end

local jdtls_settings = {
	java = {
		project = {
			referencedLibraries = {
			},
		},
		eclipse = {
			downloadSources = true,
		},
		configuration = {
			updateBuildConfiguration = 'interactive',
			runtimes = {
				{
					name = "JavaSE-17",
					path = "/usr/lib/jvm/java-17-openjdk/",
				},
				{
					name = "JavaSE-21",
					path = "/usr/lib/jvm/java-21-openjdk/",
				},
				{
					name = "JavaSE-24",
					path = "/usr/lib/jvm/java-24-openjdk/"
				}
			},
		},
		maven = {
			downloadSources = true,
		},
		implementationsCodeLens = {
			enabled = true,
		},
		referencesCodeLens = {
			enabled = true,
		},
		references = {
			includeDecompiledSources = true,
		},
		inlayHints = {
			enabled = true,
		},
		format = {
			enabled = true,
			settings = {
				url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
				profile = 'GoogleStyle'
			},
		}
	},
	signatureHelp = {
		enabled = true,
	},
	contentProvider = {
		preferred = 'fernflower',
	},
	sources = {
		organizeImports = {
			starThreshold = 9999,
			staticStarThreshold = 9999,
		}
	},
	codeGeneration = {
		toString = {
			template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
		},
		useBlocks = true,
	},
}


local path = get_jdtls_paths()

local lsp_settings = require("config.lsp-settings")
lsp_settings.config(lsp_settings.opts)

local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
local project_name = root_dir and vim.fs.basename(root_dir)
local data_dir = path.data_dir .. "/" .. project_name
local cmd = {
	'java',

	'-Declipse.application=org.eclipse.jdt.ls.core.id1',
	'-Dosgi.bundles.defaultStartLevel=4',
	'-Declipse.product=org.eclipse.jdt.ls.core.product',
	'-Dlog.protocol=true',
	'-Dlog.level=ALL',
	'-javaagent:' .. path.java_agent,
	'-Xms1g',
	'--add-modules=ALL-SYSTEM',
	'--add-opens',
	'java.base/java.util=ALL-UNNAMED',
	'--add-opens',
	'java.base/java.lang=ALL-UNNAMED',

	'-jar',
	path.launcher_jar,

	'-configuration',
	path.platform_config,

	'-data',
	data_dir,
}

local on_attach = require("config.lsp-settings").on_attach

local init_options = {
	bundles = {},
}

require("jdtls").start_or_attach({
	cmd = cmd,
	settings = jdtls_settings,
	root_dir = root_dir,
	on_attach = on_attach,
	flags = {
		allow_incremental_sync = true,
	},
	init_options = init_options,
})

