function ShowUI(focus, data)

    if data.config and not data.config.ShowNames and not data.config.ShowPing and not data.config.ShowId and not data.config.ShowJobs then return end

    SetNuiFocus(focus, focus)
    SendNUIMessage({
        action = data.action,
        players = data.players,
        config = data.config
    })
end

RegisterNUICallback('close', function()
    ShowUI(false, {action = 'hide', extra = nil})
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 51) then
            TriggerServerEvent('ui:getPlayers')
        end
    end
end)

RegisterNetEvent('ui:showPlayers')
AddEventHandler('ui:showPlayers', function(data)
    ShowUI(true, {action = 'show', players = data, config = Config})
end)