vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap.set

keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- window navigation
-- keymap('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
-- keymap('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
-- keymap('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
-- keymap('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })

-- rezing windows
keymap('n', '<A-k>', ':resize +6<CR>', { desc = 'resize window bottom' })
keymap('n', '<A-j>', ':resize -6<CR>', { desc = 'resize window top' })
keymap(
  'n',
  '<A-l>',
  ':vertical resize -24<CR>',
  { desc = 'resize window left' }
)
keymap(
  'n',
  '<A-h>',
  ':vertical resize +24<CR>',
  { desc = 'resize window right' }
)

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', { desc = 'Go to next buffer' })
keymap('n', '<S-h>', ':bprevious<CR>', { desc = 'Go to previous buffer' })
keymap('n', '<C-c>', ':bdelete!<CR>', { desc = 'Close active buffer' })

-- Visual --
-- indentation
keymap('v', '<', '<gv', { desc = 'Left text indentation' })
keymap('v', '>', '>gv', { desc = 'Right text indentation' })

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv", { desc = 'Move text top' })
keymap('x', 'K', ":move '<-2<CR>gv-gv", { desc = 'Move text bottom' })
keymap('n', '<C-s>af', ':wa<CR>', { desc = 'Save all file' })
keymap('n', '<C-s>f', ':w<CR>', { desc = 'Save file' })

-- Hacks from thePrimeagen
keymap('n', 'J', 'mzJ`z', { desc = 'Wrap line with cursor on start line' })

keymap(
  'n',
  '<C-d>',
  '<C-d>zz',
  { desc = 'Move on file downwards with cursor centered' }
)

keymap(
  'n',
  '<C-u>',
  '<C-u>zz',
  { desc = 'Move on file upwards with cursor centered' }
)

keymap(
  'n',
  'n',
  'nzzzv',
  { desc = 'Move on searched word on file downwards with cursor centered' }
)

keymap(
  'n',
  'N',
  'Nzzzv',
  { desc = 'Move on searched word on file upwards with cursor centered' }
)

keymap(
  'n',
  '<leader>s',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Multicursor replace word' }
)

