ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    TriggerServerEvent("InchallahGarage:JSON:GetGarage")
end)

Garage = {
    Load = false,
    Data = {
        Garage = nil,
        vPlayer = {},
    },
    Selected = {
        Garage = {},
        Vehicle = {},
    },
    Functions = {},
    Menus = {
        ManageGarage = false,
        Garage = false,
    }
}

RegisterCommand("Manage_Garage", function()
    Garage.Functions.ShowManageGarage()
end)

RegisterNetEvent("InchallahGarage:JSON:GetGarage")
AddEventHandler("InchallahGarage:JSON:GetGarage", function(gData)
    Garage.Data.Garage = gData
    if not Garage.Load then
        Garage.Functions.LoadMarkers()
        Garage.Load = true
    end
end)


RegisterNetEvent("InchallahGarage:GetVehiclePlayer")
AddEventHandler("InchallahGarage:GetVehiclePlayer", function(vData)
    Garage.Data.vPlayer = vData
    Garage.Functions.ShowGarage()
end)

RegisterNetEvent("InchallahGarage:DeleteVehicleStock")
RegisterNetEvent("InchallahGarage:DeleteVehicleStock", function(veh)
    ESX.Game.DeleteVehicle(veh)
end)