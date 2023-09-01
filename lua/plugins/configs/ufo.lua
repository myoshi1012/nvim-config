vim.keymap.set('n', 'zR', require 'ufo'.openAllFolds)
vim.keymap.set('n', 'zM', require 'ufo'.closeAllFolds)
vim.keymap.set('n', 'zr', require 'ufo'.openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require 'ufo'.closeFoldsWith)
vim.keymap.set('n', 'K', function()
  local winid = require 'ufo'.peekFoldedLinesUnderCursor()
  if not winid then
    -- choose one of coc.nvim and nvim lsp
    vim.lsp.buf.hover()
  end
end)

local ftMap = {
  vim = 'indent',
  python = { 'indent' },
  git = ''
}

---@param bufnr number
---@return Promise
local function customizeSelector(bufnr)
  local function handleFallbackException(err, providerName)
    if type(err) == 'string' and err:match 'UfoFallbackException' then
      return require 'ufo'.getFolds(bufnr, providerName)
    else
      return require 'promise'.reject(err)
    end
  end

  return require 'ufo'.getFolds(bufnr, 'lsp'):catch(function(err)
    return handleFallbackException(err, 'treesitter')
  end):catch(function(err)
    return handleFallbackException(err, 'indent')
  end)
end

-- #region
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ('  %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end
-- #endregion


require 'ufo'.setup {
  close_fold_kinds = { 'imports', 'comment', 'region' },
  preview = {
    win_config = {
      border = { '', '─', '', '', '', '─', '', '' },
      winhighlight = 'Normal:Folded',
      winblend = 0
    },
    mappings = {
      scrollU = '<C-u>',
      scrollD = '<C-d>'
    }
  },
  fold_virt_text_handler = handler,
  provider_selector = function(bufnr, filetype, buftype)
    if vim.bo[bufnr].bt == 'nofile' then
      return ''
    end
    return ftMap[filetype] or customizeSelector
  end
}
