fx_version 'adamant'
game 'gta5'
lua54 'yes'

client_scripts {
    "rUI/RMenu.lua",
    "rUI/menu/RageUI.lua",
    "rUI/menu/Menu.lua",
    "rUI/menu/MenuController.lua",
    "rUI/components/*.lua",
    "rUI/menu/elements/*.lua",
    "rUI/menu/items/*.lua",
    "rUI/menu/panels/*.lua",
    "rUI/menu/windows/*.lua",
}

client_scripts {
    "Client/*.lua",
}

server_scripts {
    "Server/*.lua",
    '@mysql-async/lib/MySQL.lua',
}
