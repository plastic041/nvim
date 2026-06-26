require("config.lazy")

if vim.g.vscode then
	vim.cmd[[source $HOME/.config/nvim/vscode/settings.vim]]
end

-- ; 와 : 서로 바꾸기
vim.keymap.set({ "n", "v", "o" }, ";", ":", { desc = "Command mode" })
vim.keymap.set({ "n", "v", "o" }, ":", ";", { desc = "Repeat f/t/F/T" })

-- ESC로 insert -> normal 빠져나갈 때 영어 입력기로 전환
vim.keymap.set({ "i", "n" }, "<Esc>", function()
	vim.fn.jobstart({ "macism", "com.apple.keylayout.ABC" })
	return "<Esc>"
end, { expr = true, desc = "Escape and switch to English input" })
