return {
	-- LSP 서버 설치 관리자
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			-- mason 으로 서버 자동 설치 (직접 enable 은 아래에서 한다)
			require("mason-lspconfig").setup {
				ensure_installed = { "vtsls", "vue_ls", "rust_analyzer" },
				automatic_enable = false,
			}

			-- blink.cmp 의 자동완성 capabilities 를 모든 서버에 적용
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			vim.lsp.config("*", { capabilities = capabilities })

			-- Vue: mason 으로 설치된 @vue/language-server 경로
			local vue_ls_path = vim.fn.stdpath("data")
				.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

			local vue_plugin = {
				name = "@vue/typescript-plugin",
				location = vue_ls_path,
				languages = { "vue" },
				configNamespace = "typescript",
			}

			-- TypeScript/JS (+ Vue 파일 처리용 플러그인 탑재)
			vim.lsp.config("vtsls", {
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = { vue_plugin },
						},
					},
				},
				filetypes = {
					"typescript",
					"javascript",
					"javascriptreact",
					"typescriptreact",
					"vue",
				},
			})

			-- Vue 언어 서버
			vim.lsp.config("vue_ls", {})

			-- Rust
			vim.lsp.config("rust_analyzer", {})

			vim.lsp.enable { "vtsls", "vue_ls", "rust_analyzer" }

			-- 호버: K -> gh
			pcall(vim.keymap.del, "n", "K")
			vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "LSP Hover" })
		end,
	},
}
