fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Renovax Scripts | Golden Meow'
description '[FREE] Dustbin Looting System for ESX/QBCore'
version '1.0.0'

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}
