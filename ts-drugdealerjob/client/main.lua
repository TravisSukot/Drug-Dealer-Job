-- Variables
local TSCore = exports['ts-core']:GetCoreObject()
local PlayerJob = {}

-- Events
AddEventHandler('TSCore:Client:OnPlayerLoaded', function()
    PlayerJob = TSCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('TSCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('ts-drgudealerjob:client:openStash', function()
    if PlayerJob and PlayerJob.name == 'drugdealer' then
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'drugdealer', {
            maxweight = 1000000,
            slots = 200,
        })
        TriggerEvent('inventory:client:SetCurrentStash', 'drugdealer')
    end
end)

RegisterNetEvent('ts-drgudealerjob:client:openShop', function()
    if PlayerJob and PlayerJob.name == 'drugdealer' then
        TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'drugdealer', Config.Items)
    end
end)

-- Threads
CreateThread(function()
    if TSCore.Functions.GetPlayerData().job then
        PlayerJob = TSCore.Functions.GetPlayerData().job
    end
end)

CreateThread(function()
    exports['ts-target']:AddBoxZone('drugdealerstash', vector3(1539.632, 1708.7048, 109.85663), 1.4, 3.0, {
        name='drugdealerstash',
        heading=58.693962,
        debugPoly=false,
        }, {
        options = {
            {
                event = 'ts-drgudealerjob:client:openStash',
                icon = 'fas fa-box', 
                label = 'Open Drugs Stash',
                job = 'drugdealer',
            },
        },
        distance = 2.0
    })

    exports['ts-target']:AddBoxZone('drugdealershop', vector3(1541.3278, 1708.5106, 109.90553), 0.8, 1.0, {
        name='drugdealershop',
        heading=342.5523,
        debugPoly=false,
        }, {
        options = {
            {
                event = 'ts-drgudealerjob:client:openShop',
                icon = 'fas fa-shopping-basket	', 
                label = 'Open Drugs Shop',
                job = 'drugdealer',
            },
        },
        distance = 2.0
    })
end)
