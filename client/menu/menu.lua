if FrootConfig.MenuVIP then
    
local vipMenu = RageUI.CreateMenu("V.I.P.", "V.I.P. MENU")
local pedvipSubMenu = RageUI.CreateSubMenu(vipMenu, "V.I.P.", "V.I.P. MENU")
vipMenu.Closed = function()
    open = false
    RageUI.Visible(vipMenu, false)
end

function OpenVIPMenu()
    if open then
        open = false
        RageUI.Visible(vipMenu, false)
    else
        open = true
        RageUI.Visible(vipMenu, true)
        Citizen.CreateThread(function()
            while open do
                Wait(1)

                RageUI.IsVisible(vipMenu, function()
                    RageUI.Button("Peds", description, {}, true, {}, pedvipSubMenu)
                end)

                RageUI.IsVisible(pedvipSubMenu, function()
                    RageUI.Button("Reprendre son personnage", description, {}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback('::{korioz#0110}::esx_skin:getPlayerSkin', function(skin, jobSkin)
                                local isMale = skin.sex == 0
                                TriggerEvent('::{korioz#0110}::skinchanger:loadDefaultModel', isMale, function()
                                    ESX.TriggerServerCallback('::{korioz#0110}::esx_skin:getPlayerSkin', function(skin)
                                        TriggerEvent('::{korioz#0110}::skinchanger:loadSkin', skin)
                                        TriggerEvent('::{korioz#0110}::esx:restoreLoadout')
                                    end)
                                end)
                        
                            end)
                        end
                    })
                    for k, v in pairs(FrootConfig.PedsList) do
                    RageUI.Button(v.Label, description, {}, true, {
                        onSelected = function()
                            ApplyPed(v.Name)
                        end
                    })
                    end
                end)

            end
        end)
    end
end

RegisterCommand('vipmenu', function()
    ESX.TriggerServerCallback('Froot:getVip', function(vip)
        if vip == 1 then
            OpenVIPMenu()
        else
            Notif('~p~Vous n\'êtes pas V.I.P.')
        end
    end)
end, false)



end