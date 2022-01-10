fx_version 'adamant'
game 'gta5'

client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua"

}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'shared/config.lua',
    'server/server.lua'
}

client_scripts {
    'shared/config.lua',
    'client/function.lua',
    'client/menu/*.lua',
    'client/shops/*.lua'
}
