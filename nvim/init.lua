-- universal minimalist neovim configuration

-- 1. global settings and custom leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. interface performance and behavior styles
local opt = vim.opt

opt.number = true            -- show standard line numbers
opt.relativenumber = true    -- relative line numbers for instant jumps
opt.clipboard = "unnamedplus" -- universal clipboard handshake

-- indentation laws
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- display layout parameters
opt.termguicolors = true     -- true color support
opt.signcolumn = "yes"       -- preserve layout width for diagnostics
opt.cursorline = true        -- highlight the active code line
opt.scrolloff = 8            -- keep context lines visible when scrolling

-- high-speed search filters
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false         -- drop sticky search highlights instantly

-- 3. custom minimalist keyboard mappings
local keymap = vim.keymap.set

-- lightning-fast file operations
keymap("n", "<leader>w", "<cmd>w<cr>", { desc = "save file" })
keymap("n", "<leader>q", "<cmd>q<cr>", { desc = "quit editor" })

-- clear search selection with terminal escape key
keymap("n", "<esc>", "<cmd>noh<cr><esc>")

-- maintain screen center when executing vertical line page jumps
keymap("n", "<c-d>", "<c-d>zz")
keymap("n", "<c-u>", "<c-u>zz")

-- clean split layout controls
keymap("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "split window vertically" })
keymap("n", "<leader>sh", "<cmd>split<cr>", { desc = "split window horizontally" })
keymap("n", "<leader>sx", "<cmd>close<cr>", { desc = "close active split layout" })
