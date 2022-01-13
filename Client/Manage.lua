RMenu.Add("Garage", "Main", RageUI.CreateMenu("Gestions de Garage", " ", nil , 160))
RMenu.Add("Garage", "Create", RageUI.CreateSubMenu(RMenu:Get("Garage", "Main"), "Créations", " "))
RMenu.Add("Garage", "Manage", RageUI.CreateSubMenu(RMenu:Get("Garage", "Main"), "Modifier", " "))
RMenu:Get("Garage", "Main").Closed = function()
    Garage.Functions.CloseMenu()
end;
RMenu:Get("Garage", "Main").onIndexChange = function(Index)
end
local CreateGarage = {
    Name = nil,
    pMenu = nil,
    pSpawn = nil,
    hSpawn = nil,
    pDelete = nil,
}
Garage.Functions.ShowManageGarage = function()
    if Garage.Menus.ManageGarage then Garage.Functions.CloseMenu() return end
    Garage.Menus.ManageGarage = true
    RageUI.Visible(RMenu:Get("Garage", "Main"), not RageUI.Visible(RMenu:Get("Garage", "Main")))
    Citizen.CreateThread(function()
        while Garage.Menus.ManageGarage do
            Wait(1)
            RageUI.IsVisible(RMenu:Get("Garage", "Main"), function()
                RageUI.Button("Créer un Garage", nil, {RightLabel = "→"}, true, {}, RMenu:Get("Garage", "Create"))
                RageUI.Button("Modifier un Garage", nil, {RightLabel = "→"}, true, {}, RMenu:Get("Garage", "Manage"))
            end, function() 
            end)
            RageUI.IsVisible(RMenu:Get("Garage", "Manage"), function()
                if Garage.Data.Garage == nil then
                    RageUI.Separator("")
                    RageUI.Separator("~r~Faudrais Pensé a faire un Garage !")
                    RageUI.Separator("")
                else
                    for k,v in pairs(Garage.Data.Garage) do
                        RageUI.Button(v.Name, nil, {RightLabel = "→"}, true, {
                            onActive = function()
                                ESX.ShowHelpNotification("~INPUT_CELLPHONE_CAMERA_FOCUS_LOCK~ Point du Menu\n~INPUT_FRONTEND_LT~ Point de Spawn\n~INPUT_FRONTEND_RT~ Point de Delete\n~INPUT_FRONTEND_ACCEPT~ Sauvegarder\n~INPUT_CELLPHONE_OPTION~ Supprimer")
                                if IsControlJustPressed(0, 182) then
                                    v.pMenu = GetEntityCoords(PlayerPedId())
                                elseif IsControlJustPressed(0, 209) then
                                    v.pSpawn = GetEntityCoords(PlayerPedId())
                                    v.hSpawn = GetEntityHeading(PlayerPedId())
                                elseif IsControlJustPressed(0, 208) then
                                    v.pDelete = GetEntityCoords(PlayerPedId())
                                elseif IsControlJustPressed(0,178) then
                                    table.remove(Garage.Data.Garage, k)
                                    TriggerServerEvent("InchallahGarage:JSON:Save", Garage.Data.Garage)
                                end
                            end,
                            onSelected = function()
                                TriggerServerEvent("InchallahGarage:JSON:Save", Garage.Data.Garage)
                            end
                        })
                    end
                end
            end, function()
            end)
            RageUI.IsVisible(RMenu:Get("Garage", "Create"), function()
                RageUI.Button("~r~Reset la Création", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        CreateGarage = {
                            Name = nil,
                            pMenu = nil,
                            pSpawn = nil,
                            hSpawn = nil,
                            pDelete = nil,
                        }
                    end
                })
                RageUI.Button("Nom du Garage", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        CreateGarage.Name = Garage.Functions.InputText("Nom du Garage ", "", 15)
                    end
                })
                RageUI.Button("Point du Menu", nil, {RightLabel = "→"}, CreateGarage.Name ~= nil, {
                    onSelected = function()
                        CreateGarage.pMenu = GetEntityCoords(PlayerPedId())
                    end
                })
                RageUI.Button("Point de Spawn", nil, {RightLabel = "→"}, CreateGarage.pMenu ~= nil, {
                    onSelected = function()
                        CreateGarage.pSpawn = GetEntityCoords(PlayerPedId())
                        CreateGarage.hSpawn = GetEntityHeading(PlayerPedId())
                    end
                })
                RageUI.Button("Point de Delete", nil, {RightLabel = "→"}, CreateGarage.pSpawn ~= nil, {
                    onSelected = function()
                        CreateGarage.pDelete = GetEntityCoords(PlayerPedId())
                    end
                })
                RageUI.Button("~g~Sauvegarder le Garage", nil, {RightLabel = "→"}, CreateGarage.pDelete ~= nil, {
                    onSelected = function()
                        table.insert(Garage.Data.Garage, CreateGarage)
                        TriggerServerEvent("InchallahGarage:JSON:Save", Garage.Data.Garage)
                    end
                })
            end, function()
            end)
        end
    end)
end