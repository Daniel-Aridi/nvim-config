vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

require("nvim-tree.api").tree.change_root_to_node()
require("nvim-tree.api").tree.reload()

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>', { desc = "Toggle file explorer" })


require("nvim-tree").setup({
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true }
    end

    vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))

    -- Custom `L` to step into folder cleanly
    vim.keymap.set("n", "L", function()
      local node = api.tree.get_node_under_cursor()
      if node and node.type == "directory" then
        api.tree.change_root_to_node()
        api.tree.reload()
      else
        api.node.open.edit()
      end
    end, opts("Step into folder (clean)"))

    -- H = step back to parent and reload cleanly
    vim.keymap.set("n", "H", function()
      api.tree.change_root_to_parent()
      api.tree.reload()
    end, opts("Go to parent folder"))
  end,
})



