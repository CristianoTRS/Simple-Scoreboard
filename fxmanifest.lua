fx_version 'adamant'

game 'gta5'

author 'CristianoTRS#5521'

description 'Just a simple and clean scoreboard made with Bootstrap :D'

ui_page 'html/index.html'

client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

files {
    'html/*'
}

depedencies {
    'esx_vehicleshop'
}