lia.config.add("alcoholism_ticktime", 30, "The amount of seconds in between think updates.", nil, {
    data = {
        min = 1,
        max = 60
    },
    category = "alcoholism"
})

lia.config.add("alcoholism_degraderate", 5, "The percentage that is removed from a character's blood alcohol content per think.", nil, {
    data = {
        min = 1,
        max = 100
    },
    category = "alcoholism"
})

lia.config.add("alcoholism_effect_addalpha", 0.03, "How much alpha to change per frame for motion blur effects.", nil, {
    data = {
        form = "Float",
        min = 0.01,
        max = 1
    },
    category = "alcoholism"
})

lia.config.add("alcoholism_effect_delay", 0, "Determines the amount of time between frames to capture for motion blur.", nil, {
    data = {
        form = "Float",
        min = 0,
        max = 1
    },
    category = "alcoholism"
})