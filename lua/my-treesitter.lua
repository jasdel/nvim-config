require'nvim-treesitter.configs'.setup { 
	ensure_installed = { 
		"c", "go", "rust", "lua", "vim", "json", "typescript", "java", 
	},
	highlight = { enable = true }
}
