if FrootConfig.ShopVIP then

local shopvipMenu = RageUI.CreateMenu("V.I.P.", "V.I.P. Shop")
local itemsvipSubMenu = RageUI.CreateSubMenu(shopvipMenu, "V.I.P.", "V.I.P. Shop")
local weaponsvipSubMenu = RageUI.CreateSubMenu(shopvipMenu, "V.I.P.", "V.I.P. Shop")
shopvipMenu.Closed = function()
    open = false
    RageUI.Visible(shopvipMenu, false)
    FreezeEntityPosition(PlayerPedId(), false)
end


function OpenVIPshopvipMenu()
    if open then
        open = false
        RageUI.Visible(shopvipMenu, false)
    else
        open = true
        RageUI.Visible(shopvipMenu, true)
        Citizen.CreateThread(function()
            while open do
                Wait(1)

                RageUI.IsVisible(shopvipMenu, function()
                
                    RageUI.Button('Items V.I.P.', description, {}, true, {
                    }, itemsvipSubMenu)
                    RageUI.Button('Armes V.I.P.', description, {}, true, {
                    }, weaponsvipSubMenu)

                end)

                RageUI.IsVisible(itemsvipSubMenu, function()
                    for k, v in ipairs(FrootConfig.ShopItemsList) do
                    RageUI.Button(v.Label, description, {}, true, {
                        onSelected = function()
                            TriggerServerEvent('Froot:buyvipitem', v.Name, v.Prix)
                        end
                    })
                    end
                end)

                RageUI.IsVisible(weaponsvipSubMenu, function()
                    for k, v in ipairs(FrootConfig.ShopWeaponsList) do 
                        RageUI.Button(v.Label, description, {}, true, {
                            onSelected = function()
                                TriggerServerEvent('Froot:buyvipweapon', v.Name, v.Prix)
                            end
                        })
                    end
                end)

            end
        end)
    end
end

function CheckIfCanOpenVipMenu()
    ESX.TriggerServerCallback('Froot:getVip', function(vip)
        if vip == 1 then
            FreezeEntityPosition(PlayerPedId(), true)
            OpenVIPshopvipMenu()
        else
            Notif('~p~Vous n\'êtes pas V.I.P.')
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        local pCoords = GetEntityCoords(PlayerPedId())
        if #(pCoords - FrootConfig.ShopPos) < 1.5 then
            Help('~b~Appuyez sur E pour accéder au vendeur V.I.P.')
            if IsControlJustReleased(0, 38) then
                CheckIfCanOpenVipMenu()
            end
        elseif #(pCoords - FrootConfig.ShopPos) < 7.0 then
            DrawMarker(21, FrootConfig.ShopPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 20, 147, 220, 0, 1, 2, 0, nil, nil, 0)
        end
    end
end)


if FrootConfig.VIPShopBlips then

    Citizen.CreateThread(function()
        local

        vipblips = AddBlipForCoord(FrootConfig.ShopPos)
        SetBlipSprite(vipblips, 304)
        SetBlipDisplay(vipblips, 4)
        SetBlipScale(vipblips, 1.0)
        SetBlipColour(vipblips, 5)
        SetBlipAsShortRange(vipblips, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Boutique V.I.P.")
        EndTextCommandSetBlipName(vipblips)        
    end)

end


end