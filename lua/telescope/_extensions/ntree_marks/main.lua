-- telescope modules
local pickers = require("telescope.pickers")
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local _actions = require("telescope._extensions.ntree_marks.actions")
local _finders = require("telescope._extensions.ntree_marks.finders")

local M = {}

local theme_opts = {}
M.setup = function(config)

end

M.ntree_marks = function(opts)
    opts = vim.tbl_deep_extend("force", theme_opts, opts or {})
    pickers.new(opts, {
        prompt_title = 'BookMarks', results_title = 'Nvim-Tree BookMarks',
        finder = _finders.make_finder(opts),
        attach_mappings = function(prompt_bufnr, map)
            local refresh_picker = function()
                local new_finder = _finders.make_finder(opts)
                if new_finder then
                    action_state.get_current_picker(prompt_bufnr):refresh(new_finder)
                else
                    actions.close(prompt_bufnr)
                end
            end
            _actions.remove_bookmark:enhance { post = refresh_picker }

            map('n', 'dd', _actions.remove_bookmark)
            return true
        end
    }):find()
end

return M
