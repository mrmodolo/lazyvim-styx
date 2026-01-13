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
-- return {
--   {
--     "neovim/nvim-lspconfig",
--     opts = function(_, opts)
--       local configs = require("lspconfig.configs")
--       local util = require("lspconfig.util")
--
--       -- 🔑 Registrar o servidor se ainda não existir
--       if not configs.chicken_lsp then
--         configs.chicken_lsp = {
--           default_config = {
--             cmd = { "chicken-lsp-server" },
--             filetypes = { "scheme" },
--             root_dir = util.root_pattern(".git", "."),
--           },
--         }
--       end
--
--       -- 🔗 Ativar no LazyVim
--       opts.servers = opts.servers or {}
--       opts.servers.chicken_lsp = {}
--     end,
--   },
-- }

-- return {
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       servers = {
--         chicken_lsp_server = {
--           cmd = { "chicken-lsp-server", "--stdio" },
--           filetypes = { "scheme" },
--           root_dir = function(fname)
--             return require("lspconfig.util").root_pattern("egg", ".git", "Makefile")(fname) or vim.fn.getcwd()
--           end,
--           single_file_support = true,
--         },
--       },
--     },
--   },
-- }

-- return {
--   "neovim/nvim-lspconfig",
--   opts = {
--     -- A tabela 'servers' permite configurar servidores conhecidos ou definir novos
--     servers = {
--       chicken_lsp = {
--         -- O comando para iniciar o servidor
--         cmd = { "chicken-lsp-server" },
--         -- Tipos de arquivo que ativarão este LSP
--         filetypes = { "scheme" },
--         -- Como encontrar a raiz do projeto (ex: pasta com .git ou arquivo .egg)
--         root_dir = require("lspconfig.util").root_pattern(".git", "*.egg", "Makefile"),
--         -- Configurações opcionais
--         single_file_support = true,
--       },
--     },
--     keys = {
--       { "K", false },
--       { "<leader>ck", vim.lsp.buf.hover, desc = "Hover (Chicken)" },
--       {
--         "<leader>ck",
--         "<cmd>!chicken-doc <cword><cr>",
--         desc = "Show Chicken Doc",
--         mode = "n",
--       },
--     },
--     -- Certifique-se de que o Mason não tente instalar isso, pois instalamos manualmente
--     setup = {
--       chicken_lsp = function()
--         -- Retorna false para evitar que o mason-lspconfig tente configurar isso
--         -- (já que estamos configurando manualmente acima)
--         return false
--       end,
--     },
--   },
-- }

-- return {
--   "neovim/nvim-lspconfig",
--   opts = function(_, opts)
--     local lspconfig = require("lspconfig")
--     local configs = require("lspconfig.configs")
--
--     -- Define the custom Chicken Scheme server
--     if not configs.chicken_lsp then
--       configs.chicken_lsp = {
--         default_config = {
--           cmd = { "chicken-lsp-server" },
--           filetypes = { "scheme" },
--           root_dir = function(fname)
--             return lspconfig.util.root_pattern("egg", ".git", "Makefile")(fname) or vim.fn.getcwd()
--           end,
--           single_file_support = true,
--           settings = {},
--           keys = {
--             { "K", false },
--             { "gh", vim.lsp.buf.hover, desc = "Hover (Chicken)" },
--             {
--               "gh",
--               "<cmd>!chicken-doc <cword><cr>",
--               desc = "Show Chicken Doc",
--               mode = "n",
--             },
--           },
--         },
--       }
--     end
--
--     -- Setup the server
--     lspconfig.chicken_lsp.setup({})
--     -- 2. REGISTRAR O SERVIDOR (Isso manda o LazyVim ligar ele)
--     opts.servers = opts.servers or {}
--
--     opts.servers.chicken_lsp = {}
--   end,
-- }

-- return {
--   "neovim/nvim-lspconfig",
--   opts = function(_, opts)
--     local lspconfig = require("lspconfig")
--     local configs = require("lspconfig.configs")
--
--     -- 1. Definir o servidor customizado (sem alterar nada aqui)
--     if not configs.chicken_lsp then
--       configs.chicken_lsp = {
--         default_config = {
--           cmd = { "chicken-lsp-server" },
--           filetypes = { "scheme" },
--           root_dir = function(fname)
--             return lspconfig.util.root_pattern(".git", "egg", "Makefile")(fname) or vim.fn.getcwd()
--           end,
--           settings = {},
--         },
--       }
--     end
--
--     -- 2. Registrar e Configurar (A MÁGICA ESTÁ AQUI)
--     opts.servers = opts.servers or {}
--
--     opts.servers.chicken_lsp = {
--       -- Esta tabela 'keys' diz ao LazyVim para sobrescrever os atalhos
--       -- APENAS quando o chicken_lsp estiver ativo.
--       keys = {
--         {
--           "K",
--           function()
--             local word = vim.fn.expand("<cword>")
--             if word ~= "" then
--               vim.cmd("!chicken-doc " .. word)
--             end
--           end,
--           desc = "Chicken Doc (Terminal)",
--         },
--       },
--     }
--
--     lspconfig.chicken_lsp.setup({})
--   end,
-- }

-- return {
--   {
--     "neovim/nvim-lspconfig",
--     opts = function(_, opts)
--       local lspconfig = require("lspconfig")
--       local configs = require("lspconfig.configs")
--
--       -- 1. Definir o servidor customizado
--       if not configs.chicken_lsp then
--         configs.chicken_lsp = {
--           default_config = {
--             cmd = { "chicken-lsp" },
--             filetypes = { "scheme" },
--             root_dir = function(fname)
--               return lspconfig.util.root_pattern(".git", "egg", "Makefile")(fname) or vim.fn.getcwd()
--             end,
--             settings = {},
--           },
--         }
--       end
--
--       -- 2. Configurar o servidor
--       lspconfig.chicken_lsp.setup({})
--
--       -- 3. A CORREÇÃO (Autocomando LspAttach)
--       -- Isso roda toda vez que um LSP se conecta a um buffer
--       vim.api.nvim_create_autocmd("LspAttach", {
--         callback = function(args)
--           local client = vim.lsp.get_client_by_id(args.data.client_id)
--
--           -- Verificamos se é o nosso servidor do Chicken
--           if client and client.name == "chicken_lsp" then
--             -- TRUQUE: Dizemos ao Neovim que este servidor NÃO suporta hover.
--             -- Isso previne o erro "textDocument/hover is not supported..."
--             client.server_capabilities.hoverProvider = false
--
--             -- FORÇA BRUTA: Deletamos qualquer mapeamento existente para K neste buffer
--             pcall(vim.keymap.del, "n", "K", { buffer = args.buf })
--
--             -- Criamos o nosso mapeamento
--             vim.keymap.set("n", "<leader>K", function()
--               local word = vim.fn.expand("<cword>")
--               if word ~= "" then
--                 -- O '!' roda comando de terminal
--                 vim.cmd("!chicken-doc " .. word)
--               else
--                 print("Nenhuma palavra sob o cursor")
--               end
--             end, { buffer = args.buf, desc = "Chicken Doc (Terminal)" })
--           end
--         end,
--       })
--     end,
--   },
-- }

-- return {
--   {
--     "neovim/nvim-lspconfig",
--     opts = function(_, opts)
--       local lspconfig = require("lspconfig")
--       local configs = require("lspconfig.configs")
--
--       -- 1. Definir o servidor customizado
--       if not configs.chicken_lsp then
--         configs.chicken_lsp = {
--           default_config = {
--             cmd = { "chicken-lsp" },
--             filetypes = { "scheme" },
--             root_dir = function(fname)
--               return lspconfig.util.root_pattern(".git", "egg", "Makefile")(fname) or vim.fn.getcwd()
--             end,
--             settings = {},
--           },
--         }
--       end
--
--       -- 2. Garantir que o servidor está na lista do LazyVim
--       opts.servers = opts.servers or {}
--       opts.servers.chicken_lsp = {}
--     end,
--
--     -- 3. O SEGREDO (Configuração com atraso)
--     init = function()
--       vim.api.nvim_create_autocmd("LspAttach", {
--         callback = function(args)
--           local client = vim.lsp.get_client_by_id(args.data.client_id)
--
--           -- Se for o nosso chicken_lsp...
--           if client and client.name == "chicken_lsp" then
--             -- Desativa o aviso de capacidade (para evitar erros internos)
--             client.server_capabilities.hoverProvider = false
--
--             -- AGUARDA 500ms (Meio segundo)
--             -- Isso garante que o LazyVim já terminou de configurar tudo,
--             -- então nós chegamos por último e sobrescrevemos a tecla.
--             vim.defer_fn(function()
--               vim.keymap.set("n", "K", function()
--                 local word = vim.fn.expand("<cword>")
--                 if word ~= "" then
--                   vim.cmd("!chicken-doc " .. word)
--                 else
--                   print("Nenhuma palavra sob o cursor")
--                 end
--               end, { buffer = args.buf, desc = "Chicken Doc (Force Override)" })
--
--               -- Mensagem de confirmação (aparecerá no rodapé quando abrir o arquivo)
--               print("Chicken Doc: Tecla K remapeada com sucesso!")
--             end, 500)
--           end
--         end,
--       })
--     end,
--   },
-- }

-- return {
--   "neovim/nvim-lspconfig",
--   opts = function(_, opts)
--     local lspconfig = require("lspconfig")
--     local configs = require("lspconfig.configs")
--
--     -- 1. Definir o servidor (se ainda não existir)
--     if not configs.chicken_lsp then
--       configs.chicken_lsp = {
--         default_config = {
--           cmd = { "chicken-lsp" },
--           filetypes = { "scheme" },
--           root_dir = function(fname)
--             return lspconfig.util.root_pattern(".git", "egg", "Makefile")(fname) or vim.fn.getcwd()
--           end,
--           settings = {},
--         },
--       }
--     end
--
--     -- 2. Configuração do Servidor com on_attach customizado
--     opts.servers = opts.servers or {}
--
--     opts.servers.chicken_lsp = {
--       -- Esta função roda assim que o LSP conecta no arquivo
--       on_attach = function(client, bufnr)
--         -- A. Desativar o hover do LSP (para matar o erro "not supported")
--         client.server_capabilities.hoverProvider = false
--
--         -- B. Forçar o mapeamento da tecla K
--         vim.keymap.set("n", "K", function()
--           local word = vim.fn.expand("<cword>")
--           if word and word ~= "" then
--             vim.cmd("!chicken-doc " .. word)
--           else
--             print("Nada sob o cursor")
--           end
--         end, { buffer = 0, desc = "Chicken Doc (via on_attach)" })
--
--         -- Confirmação visual (aparecerá assim que você abrir o arquivo)
--         print("LSP Chicken conectado! Tecla K configurada.")
--       end,
--     }
--   end,
-- }
