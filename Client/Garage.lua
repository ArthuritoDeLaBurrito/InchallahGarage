RMenu.Add("Garage", "Menu", RageUI.CreateMenu("Garage", " ", nil , 160))
RMenu:Get("Garage", "Menu").Closed = function()
    Garage.Functions.CloseMenu()
end;
RMenu:Get("Garage", "Menu").onIndexChange = function(Index)
end

Garage.Functions.ShowGarage = function()
    if Garage.Menus.Garage then Garage.Functions.CloseMenu() return end
    Garage.Menus.Garage = true
    RageUI.Visible(RMenu:Get("Garage", "Menu"), not RageUI.Visible(RMenu:Get("Garage", "Menu")))
    Citizen.CreateThread(function()
        while Garage.Menus.Garage do
            Wait(1)
            RageUI.IsVisible(RMenu:Get("Garage", "Menu"), function()
                for k, v in pairs(Garage.Data.vPlayer) do
                    local hashVehicule = json.decode(v.vehicle).model
                    local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
                    if v.state then
                        RageUI.Button("Modèle → ~g~"..vehicleName, nil, {RightLabel = "~g~"..v.plate.."~s~← Plaque"}, true, {
                            onSelected = function()
                                if ESX.Game.IsSpawnPointClear(Garage.Selected.Garage.pSpawn, 3.0) then
                                    ESX.Game.SpawnVehicle(hashVehicule, Garage.Selected.Garage.pSpawn, Garage.Selected.Garage.hSpawn, function(veh) 
                                        ESX.Game.SetVehicleProperties(veh, json.decode(v.vehicle))
                                        TriggerServerEvent("InchallahGarage:SetStateVehicle", v.plate)
                                        Garage.Functions.CloseMenu()
                                    end)
                                else
                                    ESX.ShowNotification("~r~La Sortie est Bloqué")
                                end
                            end
                        })
                    else
                        RageUI.Button("Modèle → ~r~"..vehicleName, nil, {RightLabel = "~r~"..v.plate.."~s~← Plaque"}, true, {
                        })
                    end
                end
            end, function() 
            end)
        end
    end)
end