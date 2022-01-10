ESX = nil

TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Froot:getVip', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT vip FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(vip)
		cb(vip)
	end)
end)


RegisterNetEvent('Froot:checkVIP')
AddEventHandler('Froot:checkVIP', function(source)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT vip FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(vip)
		if vip == 1 then
			return
		else
			TriggerEvent(FrootConfig.BanTrigger, "V.I.P. Shop Cheat", source)
		end
	end)
end)

RegisterNetEvent('Froot:buyvipweapon')
AddEventHandler('Froot:buyvipweapon', function(weapon, price)
	TriggerEvent('Froot:checkVIP', source)
	local xPlayer = ESX.GetPlayerFromId(source)
    local pMoney = xPlayer.getMoney()
    if pMoney > price then
    xPlayer.removeMoney(price)
    xPlayer.addWeapon(weapon, 300)
    TriggerClientEvent('Froot:Notif', source, 'Vous avez acheté '..weapon..' pour '..price..'$')
    PerformHttpRequest('https://discord.com/api/webhooks/928529685137203260/sRczMIhOASROV51qor02K_cCgSc71cvnpvY05Vkg_jAdgHHgO6ITRYSpJp5-K8mIgkaJ', function(err, text, headers) end, 'POST', json.encode({username = "Vendeur Illegal", content = GetPlayerName(source)..' a acheté '..weapon..' pour '..price..'$', avatar_url = "https://cdn.discordapp.com/icons/906379649779650613/6563e0398fe03bbebae32c65fc484790.png?size=4096" }), { ['Content-Type'] = 'application/json' })
    else
        TriggerClientEvent('Froot:Notif', source, 'Vous n\'avez pas assez d\'argent')
        PerformHttpRequest('https://discord.com/api/webhooks/928529685137203260/sRczMIhOASROV51qor02K_cCgSc71cvnpvY05Vkg_jAdgHHgO6ITRYSpJp5-K8mIgkaJ', function(err, text, headers) end, 'POST', json.encode({username = "Vendeur Illegal", content = GetPlayerName(source)..' a essayé d\'acheter '..weapon..' pour '..price..'$', avatar_url = "https://cdn.discordapp.com/icons/906379649779650613/6563e0398fe03bbebae32c65fc484790.png?size=4096" }), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterNetEvent('Froot:buyvipitem')
AddEventHandler('Froot:buyvipitem', function(item, price)
	TriggerEvent('Froot:checkVIP', source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pMoney = xPlayer.getMoney()
    if pMoney > price then
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem(item, 1)
    TriggerClientEvent('Froot:Notif', source, 'Vous avez acheté '..item..' pour '..price..'$')
    PerformHttpRequest('https://discord.com/api/webhooks/928529685137203260/sRczMIhOASROV51qor02K_cCgSc71cvnpvY05Vkg_jAdgHHgO6ITRYSpJp5-K8mIgkaJ', function(err, text, headers) end, 'POST', json.encode({username = "Vendeur Illegal", content = GetPlayerName(source)..' a acheté '..item..' pour '..price..'$', avatar_url = "https://cdn.discordapp.com/icons/906379649779650613/6563e0398fe03bbebae32c65fc484790.png?size=4096" }), { ['Content-Type'] = 'application/json' })
    else
        TriggerClientEvent('Froot:Notif', source, 'Vous n\'avez pas assez d\'argent')
        PerformHttpRequest('https://discord.com/api/webhooks/928529685137203260/sRczMIhOASROV51qor02K_cCgSc71cvnpvY05Vkg_jAdgHHgO6ITRYSpJp5-K8mIgkaJ', function(err, text, headers) end, 'POST', json.encode({username = "Vendeur Illegal", content = GetPlayerName(source)..' a essayé d\'acheter '..item..' pour '..price..'$', avatar_url = "https://cdn.discordapp.com/icons/906379649779650613/6563e0398fe03bbebae32c65fc484790.png?size=4096" }), { ['Content-Type'] = 'application/json' })
    end
end)


