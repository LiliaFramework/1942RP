nut.config.add("sgrGroupName", "modifiedgaminggmod", "The steam group name of your group. Needs to be correct or plugin will not work.", nil, {
    category = "Steam Group Rewards"
})

nut.config.add("sgrMoneyAmount", 500, "Amount of money rewarded for joining group.", nil, {
    data = {
        min = 0,
        max = 10000
    },
    category = "Steam Group Rewards",
})

nut.config.add("sgrManualRequestDelay", 60, "The minimum wait time for !claim requesting a manual server check. Shared between players.", nil, {
    category = "Steam Group Rewards",
    data = {
        min = 1,
        max = 10000
    },
})

nut.config.add("sgrAutomaticRequestDelay", 300, "The timer interval between automatic steam group checks", function(oldValue, newValue)
    SteamGroup_CreateTimer()
end, {
    category = "Steam Group Rewards",
    data = {
        min = 1,
        max = 10000
    },
})