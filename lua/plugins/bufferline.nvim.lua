return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		vim.opt.termguicolors = true
		require("bufferline").setup {
			options = {
				-- nvim-tree 가 열려 있을 때 그 옆 공간을 비워둔다
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						separator = true,
					},
				},
				diagnostics = "nvim_lsp",
			},
		}

		-- gt: 오른쪽 버퍼, gT: 왼쪽 버퍼 (양끝에서 wrap)
		vim.keymap.set("n", "gt", "<cmd>BufferLineCycleNext<cr>", { desc = "다음 버퍼" })
		vim.keymap.set("n", "gT", "<cmd>BufferLineCyclePrev<cr>", { desc = "이전 버퍼" })
	end,
}
