require("config.lazy")

if vim.g.vscode then
    vim.cmd[[source $HOME/.config/nvim/vscode/settings.vim]]
end
