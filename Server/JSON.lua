local Garage = {}
LoadGarage = function()
    local data = LoadResourceFile("InchallahGarage", "Garage.json")
    return data and json.decode(data) or {}
end

Citizen.CreateThread(function()
    Garage = LoadGarage()
end)

RegisterServerEvent("InchallahGarage:JSON:Save")
AddEventHandler("InchallahGarage:JSON:Save", function(gData)
    local source = source
    TriggerClientEvent('esx:showAdvancedNotification', source, "Garage", "Informations", "Mise à Jour Éffectuer !", "CHAR_BLOCKED", 2)
    SaveResourceFile("InchallahGarage", "Garage.json", json.encode(gData, {indent = true}), -1)
    TriggerClientEvent("InchallahGarage:JSON:GetGarage", -1, gData)
end)

RegisterServerEvent("InchallahGarage:JSON:GetGarage")
AddEventHandler("InchallahGarage:JSON:GetGarage", function()
    local source = source
    TriggerClientEvent("InchallahGarage:JSON:GetGarage", source, Garage) 
end)