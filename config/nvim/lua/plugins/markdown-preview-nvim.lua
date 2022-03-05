--local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript
local fn = vim.fn -- call Vim functions
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options

g.mkdp_auto_start = 0
g.mkdp_auto_close = 1
g.mkdp_refresh_slow = 0
g.mkdp_command_for_global = 0
g.mkdp_open_to_the_world = 0
g.mkdp_open_ip = ""
g.mkdp_browser = ""
g.mkdp_echo_preview_url = 0
g.mkdp_browserfunc = ""
-- g.mkdp_preview_options = {
--     'mkit' =  "",
--     'katex' =  "",
--     'uml' =  "",
--     'maid' =  "",
--     'disable_sync_scroll' =  0,
--     'sync_scroll_type' =  'middle',
--     'hide_yaml_meta' =  1,
--     'sequence_diagrams' =  "",
--     'flowchart_diagrams' =  "",
--     'content_editable' =  v = false,
--     'disable_filename' =  0
--     }
g.mkdp_markdown_css = ""
g.mkdp_highlight_css = ""
g.mkdp_port = ""
g.mkdp_page_title = "「${name}」"
g.mkdp_filetypes = "markdown"
