function GetJob(identifier)
    local playerJob = nil
    while not playerJob do
        Citizen.Wait(0)
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', { ['@identifier'] = identifier }, function(result)
            MySQL.Async.fetchAll('SELECT * FROM jobs WHERE name = @name', { ['@name'] = result[1].job }, function(_result)
                playerJob = _result[1].label
            end)
        end)
    end
    return playerJob
end

function GetOnlinePlayers()

    local Players = {}

    for _, playerId in ipairs(GetPlayers()) do
        local identifier = string.sub(GetPlayerIdentifiers(playerId)[2], string.len('license:') + 1)
        local playerName = GetPlayerName(playerId)
        local playerPing = GetPlayerPing(playerId)
        local playerJob = GetJob(identifier)

        while not playerJob do
            Citizen.Wait(0)
        end

        table.insert(Players, {playerName = playerName, playerJob = playerJob, playerId = playerId, playerPing = playerPing})
    end
    return Players
end

RegisterNetEvent('ui:getPlayers')
AddEventHandler('ui:getPlayers', function()

    local _source = source

    TriggerClientEvent('ui:showPlayers', source, GetOnlinePlayers())
end)