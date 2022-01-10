ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)


function Notif(notifmsg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(notifmsg)
    DrawNotification(0,1)
end

RegisterNetEvent('Froot:Notif')
AddEventHandler('Froot:Notif', function(notif)
    Notif(notif)
end)

function Help(helpmsg)
    AddTextEntry('HelpNotification', helpmsg)
    DisplayHelpTextThisFrame('HelpNotification', false)
end

RegisterCommand('vip', function()
    ESX.TriggerServerCallback('Froot:getVip', function(vip)
        if vip == 1 then
            Notif('~p~Vous êtes V.I.P.')
        else
            Notif('~p~Vous n\'êtes pas V.I.P.')
        end
    end)
end, false)

function ApplyPed(pedsModel)
    local model = GetHashKey(pedsModel)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
end