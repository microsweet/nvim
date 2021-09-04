-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local o = vim.o
local wo = vim.wo
local bo = vim.bo
local g = vim.g
local api = vim.api
local cmd = vim.cmd

o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.encoding = 'utf-8'
o.scrolloff = 10
o.ignorecase = true

wo.number = true
wo.relativenumber = true
wo.cursorline = true
wo.concealcursor = 'v'

g.backspace = 'indent,eol,start'
g.mouse = nv
g.mapleader = ' '

-- edit <++>
api.nvim_set_keymap('n', '<leader><leader>a', '<ESC>/<++><CR>:nohlsearch<CR>d4li', {noremap = true})
api.nvim_set_keymap('', 'J', '5j', {noremap = true })
api.nvim_set_keymap('', 'K', '5k', {noremap = true })
api.nvim_set_keymap('', 'H', '5h', {noremap = true })
api.nvim_set_keymap('', 'L', '5l', {noremap = true })
api.nvim_set_keymap('n', ';', ':', {noremap = true })
api.nvim_set_keymap('n', 'S', ':w<CR>', {noremap = true })
api.nvim_set_keymap('n', 'Q', ':q<CR>', {noremap = true })
api.nvim_set_keymap('n', '<leader>sv', ':set splitright<CR>:vsplit<CR>', {noremap = true })
api.nvim_set_keymap('n', '<leader>sou', ':source $MYVIMRC<CR>', {noremap = true })
api.nvim_set_keymap('n', 'tb', ':tabe<CR>', {noremap = true })
api.nvim_set_keymap('n', 'th', ':-tabnext<CR>', {noremap = true })
api.nvim_set_keymap('n', 'tl', ':+tabnext<CR>', {noremap = true })
api.nvim_set_keymap('n', '<leader>h', '<C-W>h', {noremap = true })
api.nvim_set_keymap('n', '<leader>l', '<C-W>l', {noremap = true })
api.nvim_set_keymap('n', '<leader>j', '<C-W>j', {noremap = true })
api.nvim_set_keymap('n', '<leader>k', '<C-W>k', {noremap = true })
api.nvim_set_keymap('n', '>', '>>', {noremap = true })
api.nvim_set_keymap('n', '<', '<<', {noremap = true })
api.nvim_set_keymap('n', '<leader>res', ':res ', {noremap = true })
api.nvim_set_keymap('n', '<leader>vres', ':vertial res ', {noremap = true })
api.nvim_set_keymap('n', '<leader>v', '$v0', {noremap = true })
api.nvim_set_keymap('n', '<leader>/', ':set splitbelow<CR>:split<CR>:term<CR>', {noremap = true })
api.nvim_set_keymap('i', 'qq', '<ESC>', {noremap = true })
api.nvim_set_keymap('v', 'qq', '<ESC>', {noremap = true })
api.nvim_set_keymap('v', 'Y', '"+y', {noremap = true })
api.nvim_set_keymap('v', 'mg', 'Imagnet:?xt=urn:btih:<ESC>', {noremap = true })
api.nvim_set_keymap('n', 'r', '<Cmd>lua compile.CompileRunGcc()<CR>', {noremap = true })

cmd[[
    autocmd FileType javascript set ts=2 sts=2 sw=2 et
    autocmd FileType python set ts=2 sts=2 sw=2 et
]]


compile = require('compile')
require('plugins')
require'lspconfig'.pyright.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.clangd.setup{}
require'complekinds'.setup()
require'lspinstall'.setup()

-- compe conf
o.completeopt="menuone,noselect"
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };
  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

--NERDTree conf
g.NERDTreeShowLineNumbers = 1
g.NERDTreeAutoCenter = 1
--let NERDTreeShowHidden=1
--let NERDTreeWinSize=31
g.nerdtree_tabs_open_on_console_startup = 0
--g.NERDTreeIgnore = {".pyc","$",".swp"}
g.NERDTreeIgnore = {'.pyc','.swp'}
g.NERDTreeShowBookmarks = 1
g.nerdtree_tabs_autofind = 0
api.nvim_set_keymap('n', '<leader>nd', ':NERDTreeToggle<CR>', {noremap = true })
api.nvim_set_keymap('n', '<leader>nf', ':NERDTreeFind<CR>', {noremap = true })

-- NERDTree-git conf
g.NERDTreeGitStatusIndicatorMapCustom = {
            Modified  = "✹",
            Staged    = "✚",
            Untracked = "✭",
            Renamed   = "➜",
            Unmerged  = "═",
            Deleted   = "✖",
            Dirty     = "✗",
            Clean     = "✔︎",
            Ignored   = '☒',
            Unknown   = "?"
}

-- markdown-preview conf
g.mkdp_auto_start = 0
g.mkdp_auto_close = 1
g.mkdp_refresh_slow = 0
g.mkdp_command_for_global = 0
g.mkdp_open_to_the_world = 0
g.mkdp_open_ip = ''
g.mkdp_echo_preview_url = 0
g.mkdp_browser = '/usr/bin/chromium'
g.mkdp_preview_options = {
    mkit = {}, 
    katex = {}, 
    uml = {}, 
    maid = {}, 
    disable_sync_scroll = 0, 
    sync_scroll_type = 'middle', 
    hide_yaml_meta = 1
}
g.mkdp_markdown_css = ''
g.mkdp_highlight_css = ''
g.mkdp_port = ''
g.mkdp_page_title = '「${name}」'

-- vim-go conf
g.go_def_mapping_enabled = 0
g.go_template_autocreate = 0
g.go_textobj_enabled = 0
g.go_auto_type_info = 1
g.go_def_mapping_enabled = 0
g.go_highlight_array_whitespace_error = 1
g.go_highlight_build_constraints = 1
g.go_highlight_chan_whitespace_error = 1
g.go_highlight_extra_types = 1
g.go_highlight_fields = 1
g.go_highlight_format_strings = 1
g.go_highlight_function_calls = 1
g.go_highlight_function_parameters = 1
g.go_highlight_functions = 1
g.go_highlight_generate_tags = 1
g.go_highlight_methods = 1
g.go_highlight_operators = 1
g.go_highlight_space_tab_error = 1
g.go_highlight_string_spellcheck = 1
g.go_highlight_structs = 1
g.go_highlight_trailing_whitespace_error = 1
g.go_highlight_types = 1
g.go_highlight_variable_assignments = 0
g.go_highlight_variable_declarations = 0
g.go_doc_keywordprg_enabled = 0

-- indentLine conf
g.indentLine_char = '│'
g.indentLine_color_term = 238
g.indentLine_color_gui = '#333333'
api.nvim_command('silent! unmap <LEADER>ig')
api.nvim_command('autocmd WinEnter * silent! unmap <LEADER>ig')
g.indentLine_fileTypeExclude = {'tex'}
g.indentLine_concealcursor = 'v'
g.indentLine_conceallevel = 2

-- vim-table-mode conf
api.nvim_set_keymap('', '<leader>m', ':TableModeToggle<CR>', {noremap = true })

-- vim-easymoion
api.nvim_set_keymap('', '<leader>f', '<plug>(easymotion-bd-f)', { noremap= false })
api.nvim_set_keymap('n', '<leader>f', '<plug>(easymotion-overwin-f)', { noremap= false })

-- auto fcitx
g.input_toggle = 1
function Fcitx2en()
	local b = io.popen("fcitx5-remote")
	local input_status = string.gsub(b:read("*all"), "\n", "")
	input_status = tonumber(input_status)
	if(input_status == 2)
	then
		g.input_toggle = 1
		os.execute("fcitx5-remote -c")
	end
end
function Fcitx2zh()
	local b = io.popen("fcitx5-remote")
	local input_status = string.gsub(b:read("*all"), "\n", "")
	input_status = tonumber(input_status)
	if(input_status ~= 2 and g.input_toggle == 1)
	then
		g.input_toggle = 0
		os.execute("fcitx5-remote -c")
	end
end
-- leave insert
api.nvim_command('autocmd InsertLeave * lua Fcitx2en()')
-- enter insert
--api.nvim_command('autocmd InsertEnter * lua Fcitx2zh()')
