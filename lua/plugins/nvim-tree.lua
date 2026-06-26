return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local function on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- 기본 매핑 적용
      api.config.mappings.default_on_attach(bufnr)

      -- 오른쪽: 닫힌 폴더는 펼치고, 파일은 연다 (이미 열린 폴더는 그대로 둠)
      local function expand_or_open()
        local node = api.tree.get_node_under_cursor()
        if node == nil then
          return
        end
        if node.nodes ~= nil then
          -- 디렉터리: 닫혀 있을 때만 펼친다
          if not node.open then
            api.node.open.edit()
          end
        else
          -- 파일: 연다
          api.node.open.edit()
        end
      end

      vim.keymap.set("n", "l", expand_or_open, opts("Expand or Open"))
      vim.keymap.set("n", "<Right>", expand_or_open, opts("Expand or Open"))
      -- 왼쪽: 폴더 접기
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
      vim.keymap.set("n", "<Left>", api.node.navigate.parent_close, opts("Close Directory"))
    end

    require("nvim-tree").setup {
      on_attach = on_attach,
    }

    -- Command + Shift + E: tree 에 포커스 / tree 에 있으면 편집 버퍼로 포커스 (토글)
    local function toggle_tree_focus()
      if vim.bo.filetype == "NvimTree" then
        vim.cmd("wincmd p") -- 이전(편집) 창으로 포커스
      else
        vim.cmd("NvimTreeFocus")
      end
    end
    vim.keymap.set("n", "<D-S-e>", toggle_tree_focus, { desc = "Toggle focus NvimTree / editor" })
    vim.keymap.set("i", "<D-S-e>", toggle_tree_focus, { desc = "Toggle focus NvimTree / editor" })

    -- Command + B: nvim-tree 닫기
    vim.keymap.set("n", "<D-b>", "<cmd>NvimTreeClose<cr>", { desc = "Close NvimTree" })
    vim.keymap.set("i", "<D-b>", "<cmd>NvimTreeClose<cr>", { desc = "Close NvimTree" })
  end,
}
