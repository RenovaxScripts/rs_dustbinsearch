Config = {}

-- Framework: "esx" or "qbcore"
Config.framework = "esx"

-- Cooldown time in seconds
Config.Cooldown = 300

-- Possible trash loot items
Config.LootItems = {
    {item = 'water', chance = 60, min = 1, max = 3},
    {item = 'burger', chance = 40, min = 1, max = 2},
    {item = 'onion', chance = 10, min = 10, max = 50},
}

-- Bin models that can be looted
Config.TrashModels = {
    'prop_dumpster_01a',
    'prop_dumpster_02a',
    'prop_dumpster_4a',
    'prop_dumpster_02b',
    'prop_dumpster_4b',
    'prop_bin_05a',
    'prop_bin_01a'
}
