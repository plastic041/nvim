return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = {
				"typescript",
				"tsx",
				"javascript",
				"vue",
				"rust",
				"json",
				"jsonc",
				-- 설정 파일 편집용 기본 파서
				"lua",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		}
	end,
}
