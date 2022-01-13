RegisterServerEvent("InchallahGarage:GetVehiclePlayer")
AddEventHandler("InchallahGarage:GetVehiclePlayer", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner=@a', {
        ["@a"] = xPlayer.identifier
    }, function(data)
        TriggerClientEvent("InchallahGarage:GetVehiclePlayer", source, data)
    end)    
end)


RegisterServerEvent("InchallahGarage:SetStateVehicle")
AddEventHandler("InchallahGarage:SetStateVehicle", function(vPlate)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local state = false
    MySQL.Async.fetchAll("UPDATE owned_vehicles SET state =@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = vPlate})
end)

RegisterServerEvent("InchallahGarage:StockVehicleInGarage")
AddEventHandler("InchallahGarage:StockVehicleInGarage", function(vData, vPlate, veh)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local Found = false
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles', {
    }, function(data)
        for k,v in pairs(data) do
            if v.plate == vPlate then
                Found = true
                if xPlayer.identifier == v.owner then
                    MySQL.Async.fetchAll("UPDATE owned_vehicles SET state =@state WHERE plate=@plate",{['@state'] = true , ['@plate'] = vPlate})
                    MySQL.Async.fetchAll("UPDATE owned_vehicles SET vehicle =@vehicle WHERE plate=@plate",{['@vehicle'] = vData , ['@plate'] = vPlate})
                    TriggerClientEvent("InchallahGarage:DeleteVehicleStock", source, veh)
                else
                    TriggerClientEvent('esx:showNotification', source, "~r~Ceci n'est pas votre Véhicule")
                end
            end
        end
        if not Found then
            TriggerClientEvent('esx:showNotification', source, "~r~Vous ne pouvez pas rentrer ce Véhicule")
        end
    end) 
end)