-- VIP Seulement peuvent faire un truc
RegisterCommand('test', function()
    ESX.TriggerServerCallback('Froot:getVip', function(vip)
        if vip == 1 then
            --Quoi faire si le joueur est VIP
        else
            Notif('~p~Vous n\'êtes pas V.I.P.')
        end
    end)
end, false)

-- Server Verif trigger si pas VIP alors ban 
RegisterNetEvent('test')
AddEventHandler('test', function()
	TriggerEvent('Froot:checkVIP', source)
    print('Si le joueur n\'est pas ban il est alors VIP')
end)