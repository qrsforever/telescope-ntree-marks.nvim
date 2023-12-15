local transform_mod = require('telescope.actions.mt').transform_mod
local action_state = require('telescope.actions.state')

local remove_bookmark = function(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    require("nvim-tree.marks").toggle_mark(entry.node)
end

return transform_mod {
    remove_bookmark = remove_bookmark,
}
