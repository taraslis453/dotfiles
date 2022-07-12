local M = {}

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = true,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[g", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]g", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "v", "ga", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "R", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async = true})' ]])
end

local navic = require("nvim-navic")

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false

		local ts_utils = require("nvim-lsp-ts-utils")

		-- defaults
		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = true,

			-- import all
			import_all_timeout = 5000, -- ms
			import_all_priorities = nil,
			import_all_scan_buffers = 100,
			import_all_select_source = false,
			-- if false will avoid organizing imports
			always_organize_imports = false,

			-- filter diagnostics
			filter_out_diagnostics_by_severity = {},
			filter_out_diagnostics_by_code = {},

			-- inlay hints
			auto_inlay_hints = false,
			-- update imports on file move
			update_imports_on_move = true,
			require_confirmation_on_move = false,
			watch_dir = nil,
		})

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)
	end
	if client.name == "sumneko_lua" then
		client.server_capabilities.documentFormattingProvider = false
	end
	if client.name == "stylelint_lsp" then
		client.server_capabilities.documentFormattingProvider = false
	end
	if client.name == "gopls" then
		client.server_capabilities.documentFormattingProvider = false
	end
	if client.name == "eslint" then
		vim.cmd("autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll")
	end

	-- format on save
	if client.supports_method("textDocument/formatting") then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
	end
	if client.supports_method("textDocument/signatureHelp") then
		vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
			pattern = "<buffer>",
			group = vim.api.nvim_create_augroup("LspSignature", {}),
			callback = function()
				vim.lsp.buf.signature_help()
			end,
		})
	end
	if client.supports_method("textDocument/documentSymbol") then
		navic.attach(client, bufnr)
	end

	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
