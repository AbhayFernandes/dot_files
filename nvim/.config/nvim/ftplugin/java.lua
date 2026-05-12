local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")
local home = os.getenv("HOME")

local lombok_jar = home .. "/.local/share/jdtls/lombok.jar"

local config = {
    cmd = {
        "jdtls",
        "--jvm-arg=-javaagent:" .. lombok_jar,
        "--jvm-arg=-Xmx4g",
        "--jvm-arg=-Xms1g",
        "--jvm-arg=-XX:+UseG1GC",
    },

    root_dir = jdtls_setup.find_root({ ".git", "build.gradle", "pom.xml", "settings.gradle" }),

    capabilities = {
        workspace = { configuration = true },
        textDocument = {
            completion = {
                completionItem = { snippetSupport = true }
            }
        }
    },

    settings = {
        java = {
            references = { includeDecompiledSources = true },
            eclipse = { downloadSources = true },
            maven = { downloadSources = true },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
        }
    },

    init_options = {
        bundles = {},
    },

    on_attach = function()
        jdtls.setup_dap({ hotcodereplace = "auto" })

        local dap = require("dap")
        if not dap.configurations.java then
            dap.configurations.java = {}
        end
        table.insert(dap.configurations.java, {
            type = "java",
            request = "attach",
            name = "Attach to Minecraft (localhost:5005)",
            hostName = "localhost",
            port = 5005,
        })
    end,
}

jdtls.start_or_attach(config)
