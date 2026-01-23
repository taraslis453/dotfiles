local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "info", "hint" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  colored = true,
  update_in_insert = false,
  always_visible = false,
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " },
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = true,
  icon = nil,
}

local gstatus = { ahead = 0, behind = 0 }
local function update_gstatus()
  local Job = require("plenary.job")
  Job:new({
    command = "git",
    args = { "rev-list", "--left-right", "--count", "HEAD...@{upstream}" },
    on_exit = function(job, _)
      local res = job:result()[1]
      if type(res) ~= "string" then
        gstatus = { ahead = 0, behind = 0 }
        return
      end
      local ok, ahead, behind = pcall(string.match, res, "(%d+)%s*(%d+)")
      if not ok then
        ahead, behind = 0, 0
      end
      gstatus = { ahead = ahead, behind = behind }
    end,
  }):start()
end

if _G.Gstatus_timer == nil then
  _G.Gstatus_timer = vim.loop.new_timer()
else
  _G.Gstatus_timer:stop()
end
_G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(update_gstatus))

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local spaces = function()
  return "spaces: " .. vim.bo.shiftwidth
end

local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
  return
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "catppuccin",
    disabled_filetypes = { "alpha", "dashboard", "Outline" },
    always_divide_middle = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { 
      { "mode", fmt = function(str) return str:sub(1,1) end }
    },
    lualine_b = { 
      branch,
      function()
        if gstatus.ahead == 0 and gstatus.behind == 0 then
          return ""
        end
        return " " .. gstatus.ahead .. "  " .. gstatus.behind
      end,
    },
    lualine_c = { 
      { "filename", path = 1, shorting_target = 40 },
      { navic.get_location, cond = navic.is_available, color = { fg = "#7f849c" } },
      -- Copilot status
      {
        function()
          return " "
        end,
        color = function()
          local status = require("sidekick.status").get()
          if status then
            return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
          end
        end,
        cond = function()
          local status = require("sidekick.status")
          return status.get() ~= nil
        end,
      },
    },
    lualine_x = { 
      -- CLI session status
      {
        function()
          local status = require("sidekick.status").cli()
          return " " .. (#status > 1 and #status or "")
        end,
        cond = function()
          return #require("sidekick.status").cli() > 0
        end,
        color = function()
          return "Special"
        end,
      },
      diagnostics,
      diff, 
      { spaces, icon = "󰌒" },
      filetype 
    },
    lualine_y = { 
      { "progress", padding = { left = 1, right = 1 } }
    },
    lualine_z = { 
      { "location", padding = { left = 1, right = 1 } }
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
