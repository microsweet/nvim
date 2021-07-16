--LSP UI customization, Completion kinds
local M = {}

M.icons = {
  Class = " Class",
  Color = " Color",
  Constant = " Constant",
  Constructor = " Constructor",
  Enum = "了 Enum",
  EnumMember = " EnumMember",
  Field = " Field",
  File = " File",
  Folder = " Folder",
  Function = " Function",
  Interface = "ﰮ Interface",
  Keyword = " Keyword",
  Method = "ƒ Method",
  Module = " Module",
  Property = " Property",
  Snippet = "﬌ Snippet",
  Struct = " Struct",
  Text = " Text",
  Unit = " Unit",
  Value = " Value",
  Variable = " Variable",
}

function M.setup()
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = M.icons[kind] or kind
  end
end

return M
