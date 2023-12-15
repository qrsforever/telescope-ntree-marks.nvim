local finders = require("telescope.finders")
local entry_display = require("telescope.pickers.entry_display")
local utils = require('telescope.utils')
local Marks = require("nvim-tree.marks")

local M = {}

M.make_finder = function(opts)
    local widths = {
        title = 20,
        display_path = 85,
    }

    -- local marks = vim.tbl_map(function(n)
    --     return {display_path = n.absolute_path, title = n.name}
    -- end, Marks.get_marks())

    local displayer = entry_display.create {
        separator = " ",
        items = {
            { width = widths.title },
            { width = widths.display_path },
            { remaining = true }
        }
    }
    local make_display = function(entry)
        return displayer { entry.filename, utils.path_smart(entry.path)}
    end

    return finders.new_table {
        results = Marks.get_marks(),
        entry_maker = function(entry)
            return {
                ordinal = entry.name,        -- used by telescope
                filename = entry.name,       -- used by telescope
                path = entry.absolute_path,  -- used by telescope
                absolute_path = entry.absolute_path, -- used by nvim-tree
                display = make_display,
            }
        end,
    }
end

return M
