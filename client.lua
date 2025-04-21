local Framework
if Config.framework == 'esx' then
    Framework = exports['es_extended']:getSharedObject()
elseif Config.framework == 'qbcore' then
    Framework = exports['qb-core']:GetCoreObject()
end

for _, model in pairs(Config.TrashModels) do
     if Config.framework == 'esx' then
         exports.ox_target:addModel(model, {
             label = 'Search the dustbin',
             icon = 'fas fa-trash',
             distance = 1.0,
             onSelect = function(data)
                 local coords = GetEntityCoords(data.entity)
                 local binId = string.format("%d_%d_%d", math.floor(coords.x), math.floor(coords.y), math.floor(coords.z))
 
                 TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
                 lib.progressCircle({
                     duration = 5000,
                     label = 'Searching the dustbin...',
                     position = 'bottom',
                     useWhileDead = false,
                     canCancel = false,
                 })
                 ClearPedTasks(PlayerPedId())
 
                 TriggerServerEvent('rs_dustbin:attemptLoot', binId)
             end
         })
     elseif Config.framework == 'qbcore' then
          exports['qb-target']:AddTargetModel(model, {
               options = {
                   {
                       label = 'Search the dustbin',
                       icon = 'fas fa-trash',
                       action = function(entity)
                           local coords = GetEntityCoords(entity)
                           local binId = string.format("%d_%d_%d", math.floor(coords.x), math.floor(coords.y), math.floor(coords.z))
           
                           TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
           
                           QBCore.Functions.Progressbar("search_dustbin", "Searching the dustbin...", 5000, false, true, {
                               disableMovement = true,
                               disableCarMovement = true,
                               disableMouse = false,
                               disableCombat = true,
                           }, {}, {}, {}, function()
                               ClearPedTasks(PlayerPedId())
                               TriggerServerEvent('rs_dustbin:attemptLoot', binId)
                           end, function()
                               ClearPedTasks(PlayerPedId())
                               QBCore.Functions.Notify('You stopped searching', 'error', 5000)
                           end)
                       end,
                   }
               },
               distance = 1.0,
           })           
     end
 end
 