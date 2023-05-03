PLUGIN.name = "ID System"
PLUGIN.desc = "Adds an important document with all the information about the player."
PLUGIN.author = "Leonheart#7476"
nut.util.include("cl_missingInfos.lua")
nut.util.include("sv_networking.lua")

charCharacteristics = {
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

nut.command.add("chareditpapers", {
    syntax = "",
    onRun = function(ply, args)
        netstream.Start(ply, "missingCharacteristics", "Edit your information", true)
    end
})