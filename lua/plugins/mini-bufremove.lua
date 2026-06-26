return {
	"nvim-mini/mini.bufremove",
	version = false,
	keys = {
		{
			"<leader>q",
			function()
				require("mini.bufremove").delete()
			end,
			desc = "버퍼 닫기",
		},
	},
	config = function()
		require("mini.bufremove").setup()
	end,
}
