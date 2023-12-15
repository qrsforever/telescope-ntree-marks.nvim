local has_telescope, telescope = pcall(require, 'telescope')
local main = require('telescope._extensions.ntree_marks.main')
local utils = require('telescope._extensions.project.utils')

if not has_telescope then
    error('This plugins requires nvim-telescope/telescope.nvim')
end

utils.init_files()

return telescope.register_extension{
    setup = main.setup,
    exports = { ntree_marks = main.ntree_marks }
}
