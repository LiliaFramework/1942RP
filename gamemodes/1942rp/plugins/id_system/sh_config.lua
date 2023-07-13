local PLUGIN = PLUGIN

PLUGIN.charCharacteristics = {
    ["Age(+18)"] = "number",
    ["Place of Birth"] = "string",
    ["Weight"] = "number",
    ["Height"] = {
        valueType = "choice",
        choices = {"5’1", "5’2", "5’3", "5’4", "5’5", "5’6", "5’8", "5’9", "5’10", "5’11", "6’1", "6’2", "6’3", "6’4", "6’5"}
    },
    ["Hair Color"] = {
        valueType = "choice",
        choices = {"Brown", "Black", "Blonde", "Red", "Gray"}
    },
    ["Eye Color"] = {
        valueType = "choice",
        choices = {"Blue", "Brown", "Green", "Hazel", "Gray"}
    },
    ["Religion"] = {
        valueType = "choice",
        choices = {"Catholic", "Christian", "Protestant", "Atheist", "Gottgläubig"}
    },
    ["Blood Type"] = {
        valueType = "choice",
        choices = {"O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"}
    },
}

PLUGIN.HeightEquivalentTable = {
    [1] = {"5’1", 0.9},
    [2] = {"5’2", 0.91},
    [3] = {"5’3", 0.92},
    [4] = {"5’4", 0.93},
    [5] = {"5’5", 0.94},
    [6] = {"5’6", 0.95},
    [7] = {"5’7", 0.96},
    [8] = {"5’8", 0.97},
    [9] = {"5’9", 0.98},
    [10] = {"5'10", 1.0},
    [11] = {"6'1", 1.02},
    [12] = {"6’2", 1.03},
    [13] = {"6’3", 1.04},
    [14] = {"6’4", 1.05},
    [15] = {"6’5", 1.06},
    [16] = {"6’6", 1.07},
}