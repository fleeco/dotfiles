-- Enables line numbers in the left margin, making it easier to navigate and reference specific lines in files
vim.opt.nu = true

-- Shows relative line numbers from current cursor position, useful for quick navigation with motion commands like 5j or 3k
vim.opt.relativenumber = true

-- Sets tab width to 4 spaces when displaying tab characters, controlling how existing tabs appear in the editor
vim.opt.tabstop = 4

-- Sets soft tab stop to 4 spaces, controlling backspace behavior and mixed tab/space handling during editing sessions
vim.opt.softtabstop = 4

-- Sets indentation width to 4 spaces for auto-indent operations, used by commands like >> and << for consistent formatting
vim.opt.shiftwidth = 4

-- Converts tab key presses to spaces instead of inserting actual tab characters, ensuring consistent indentation across different editors
vim.opt.expandtab = true

-- Enables smart indentation that automatically adjusts indent level based on code context like brackets and language syntax rules
vim.opt.smartindent = true

-- Disables line wrapping, allowing long lines to extend beyond screen width rather than wrapping to next visual line
vim.opt.wrap = false

-- Disables swap file creation, preventing .swp files from being created when editing files, reducing filesystem clutter and potential conflicts
vim.opt.swapfile = false

-- Disables automatic backup file creation, preventing ~ backup files from being generated when saving, keeping directories clean
vim.opt.backup = false

-- Sets directory for persistent undo files, allowing undo history to persist across vim sessions when files are reopened
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Enables persistent undo functionality, saving undo history to disk so changes can be undone even after closing and reopening files
vim.opt.undofile = true

-- Disables search result highlighting, preventing matched text from remaining highlighted after search completion, reducing visual distractions while editing
vim.opt.hlsearch = true

-- Enables incremental search, showing search matches in real-time as you type the search pattern, providing immediate visual feedback
vim.opt.incsearch = true

-- Enables true color support in terminal, allowing full 24-bit color palette for better syntax highlighting and theme appearance
vim.opt.termguicolors = true

-- Maintains 8 lines of context above and below cursor when scrolling, preventing cursor from reaching screen edges during navigation
vim.opt.scrolloff = 8

-- Always shows sign column for consistent layout, preventing text from shifting when signs like git changes or linting errors appear
vim.opt.signcolumn = "yes"

-- Adds @ and - characters to filename character set, allowing vim to recognize these as valid filename characters for commands
vim.opt.isfname:append("@-@")

-- Sets cursor hold time to 50ms, controlling how quickly certain events trigger like hover information and auto-completion popups
vim.opt.updatetime = 50
