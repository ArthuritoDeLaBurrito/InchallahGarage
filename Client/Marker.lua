local letSleep, isInMarker, hasAlreadyEnteredMarker = true, false, false

Garage.Functions.LoadMarkers = function()
    local NumberGarage = 0
    for k,v in pairs(Garage.Data.Garage) do
        NumberGarage = NumberGarage + 1 
    end
    print("^1[InchallahGarage]^7 "..NumberGarage.." Chargé avec succès !")

    Citizen.CreateThread(function()
        while true do 
            Wait(0)
            local pCoords = GetEntityCoords(PlayerPedId(), false)
            for k,v in pairs(Garage.Data.Garage) do
                local dstCheckMenu = GetDistanceBetweenCoords(pCoords, v.pMenu.x, v.pMenu.y, v.pMenu.z, true)
                if dstCheckMenu <= 5.0 then
                    letSleep = false
                    Garage.Functions.DrawM(v.pMenu.x, v.pMenu.y, v.pMenu.z)
                    if dstCheckMenu <= 2.0 then
                        isInMarker = true
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour Ouvrir le Menu")
                        if IsControlJustPressed(0, 38) then
                            Garage.Selected.Garage = v
                            TriggerServerEvent("InchallahGarage:GetVehiclePlayer")
                        end
                    else
                        isInMarker = false
                    end
                end
                local dstCheckDelete = GetDistanceBetweenCoords(pCoords, v.pDelete.x, v.pDelete.y, v.pDelete.z, true)
                if dstCheckDelete <= 5.0 then
                    letSleep = false
                    Garage.Functions.DrawM(v.pDelete.x, v.pDelete.y, v.pDelete.z)
                    if dstCheckDelete <= 2.0 then
                        isInMarker = true
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour Ranger Votre Véhicule")
                        if IsControlJustPressed(0, 38) then
                            if IsPedInAnyVehicle(PlayerPedId(),  false) then
                                local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)     
                                local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
                                local plate = vehicleProps.plate
                                TriggerServerEvent("InchallahGarage:StockVehicleInGarage",  json.encode(vehicleProps), plate, vehicle)
                            else
                                TriggerEvent('esx:showNotification', "~r~Vous n'êtes pas dans un Véhicule")
                            end
                        end
                    else
                        isInMarker = false
                    end
                end
                if isInMarker and not hasAlreadyEnteredMarker then
                    hasAlreadyEnteredMarker = true
                end
    
                if not isInMarker and hasAlreadyEnteredMarker then
                    letSleep = true
                    Garage.Functions.CloseMenu()
                    hasAlreadyEnteredMarker = false
                end
    
                if letSleep then
                    Citizen.Wait(500)
                end
            end
        end
    end)
end
