---@brief
--- Gemini response: https://gemini.google.com/app/d319018d3f6ca2dd
---
--- https://wiki.call-cc.org/eggref/5/lsp-server
---
--- Language Server Protocol (LSP) para Chicken Scheme.
---
--- Requisitos:
--- - Chicken Scheme instalado.
--- - Egg do lsp-server instalado (`chicken-install -s lsp-server`).
---
--- Este servidor fornece autocompletar, go-to-definition e documentação básica.
---
--- REPL associado ao comando: <leader>sc
---
--- ```lua
---  {
---    "neovim/nvim-lspconfig",
---    opts = function(_, opts)
---      local lspconfig = require("lspconfig")
---      local configs = require("lspconfig.configs")
---
---      -- 1. Definir a configuração do servidor customizado se ela não existir
---      if not configs.chicken_lsp then
---        configs.chicken_lsp = {
---          default_config = {
---            cmd = { "/home/modolo/.local/bin/chicken-lsp-server", "--log-level", "debug" }, -- O comando instalado pelo chicken-install
---            filetypes = { "scheme", "scm" },
---            -- Define a raiz do projeto (onde está o .git ou arquivos de configuração do egg)
---            -- root_dir = lspconfig.util.root_pattern("eggfile", ".git"),
---            root_dir = function(fname)
---              return lspconfig.util.root_pattern("egg", ".git", "Makefile")(fname) or vim.fn.getcwd()
---            end,
---            single_file_support = true,
---          },
---        }
---      end
---
---      -- 2. Habilitar o servidor na lista de servidores do LazyVim
---      opts.servers = opts.servers or {}
---      opts.servers.chicken_lsp = {
---        mason = false, -- IMPORTANTE: Diz ao LazyVim para não procurar no Mason
---        cmd = { "/home/modolo/.local/bin/chicken-lsp-server", "--log-level", "debug" }, -- Força o comando aqui também para garantir
---        filetypes = { "scheme", "scm" },
---      }
---    end,
---  }
---  ```

---@type vim.lsp.Config
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      -- 1. Definir a configuração do servidor customizado se ela não existir
      if not configs.chicken_lsp then
        configs.chicken_lsp = {
          default_config = {
            cmd = { "/home/modolo/.local/bin/chicken-lsp-server", "--log-level", "debug" }, -- O comando instalado pelo chicken-install
            filetypes = { "scheme", "scm" },
            -- Define a raiz do projeto (onde está o .git ou arquivos de configuração do egg)
            -- root_dir = lspconfig.util.root_pattern("eggfile", ".git"),
            root_dir = function(fname)
              return lspconfig.util.root_pattern("egg", ".git", "Makefile")(fname) or vim.fn.getcwd()
            end,
            single_file_support = true,
          },
        }
      end

      -- 2. Habilitar o servidor na lista de servidores do LazyVim
      opts.servers = opts.servers or {}
      opts.servers.chicken_lsp = {
        mason = false, -- IMPORTANTE: Diz ao LazyVim para não procurar no Mason
        cmd = { "/home/modolo/.local/bin/chicken-lsp-server", "--log-level", "debug" }, -- Força o comando aqui também para garantir
        filetypes = { "scheme", "scm" },
      }
    end,
  },
}
