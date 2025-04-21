local lootedBins = {}

if Config.framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
elseif Config.framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
end

local function getPlayer(source)
    if Config.framework == 'esx' then
        return ESX.GetPlayerFromId(source)
    else
        return QBCore.Functions.GetPlayer(source)
    end
end

local function addLootToPlayer(player, item, amount)
     local src = source
    if GetResourceState('ox_inventory') == 'started' then
        exports.ox_inventory:AddItem(player.source, item, amount)
        TriggerClientEvent('inventory:client:ItemBox', player.source, item, 'add')
    else
        if Config.framework == 'esx' then
            player.addInventoryItem(item, amount)
        else
            player.Functions.AddItem(item, amount)
            TriggerClientEvent('inventory:client:ItemBox', player.source, QBCore.Shared.Items[item], 'add')
        end
    end
    if GetResourceState('ox_lib') == 'started' then
     TriggerClientEvent('ox_lib:notify', src, {
          title = 'Dustbin',
          description = 'You get some ' .. amount .. 'x ' .. item .. ' from the dustbin.',
          type = 'success'
      })
 else
     if Config.framework == 'esx' then
        TriggerClientEvent('esx:showNotification', src, 'You get some ' .. amount .. 'x ' .. item .. ' from the dustbin.')
     else
          TriggerClientEvent('QBCore:Notify', src, 'You get some ' .. amount .. 'x ' .. item .. ' from the dustbin.', 'success')
     end
 end
end

RegisterServerEvent('rs_dustbin:attemptLoot', function(binId)
     local src = source
     local player = getPlayer(src)
     if not player then return end
 
     local currentTime = os.time()
     if lootedBins[binId] and (currentTime - lootedBins[binId]) < Config.Cooldown then
          if GetResourceState('ox_lib') == 'started' then
               TriggerClientEvent('ox_lib:notify', src, {
                    title = 'Dustbin',
                    description = 'This dustbin was recently searched.',
                    type = 'error'
                })
           else
               if Config.framework == 'esx' then
                  TriggerClientEvent('esx:showNotification', src, 'This dustbin was recently searched.')
               else
                    TriggerClientEvent('QBCore:Notify', src, 'This dustbin was recently searched.', 'error')
               end
           end
         return
     end
 
     lootedBins[binId] = currentTime
 
     local foundItem = false
 
     for _, loot in pairs(Config.LootItems) do
         if math.random(1, 100) <= loot.chance then
             local amount = math.random(loot.min, loot.max)
             addLootToPlayer(player, loot.item, amount)
             foundItem = true
         end
     end
 
     if not foundItem then
          if GetResourceState('ox_lib') == 'started' then
               TriggerClientEvent('ox_lib:notify', src, {
                    title = 'Dustbin',
                    description = 'Nothing was found in this dustbin.',
                    type = 'info'
                })
           else
               if Config.framework == 'esx' then
                  TriggerClientEvent('esx:showNotification', src, 'Nothing was found in this dustbin.')
               else
                    TriggerClientEvent('QBCore:Notify', src, 'Nothing was found in this dustbin.', 'error')
               end
           end
     end
 end)
 