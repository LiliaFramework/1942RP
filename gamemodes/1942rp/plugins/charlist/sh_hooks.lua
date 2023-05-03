function nut.setCharData(charID, key, val)
    local charIDsafe = tonumber(charID)
    if not charIDsafe then return end
    local data = nut.getCharData(charID)
    if not data then return false end
    data[key] = val
    local setQ = "UPDATE nut_characters SET _data=" .. sql.SQLStr(util.TableToJSON(data)) .. " WHERE _id=" .. charIDsafe

    if sql.Query(setQ) == false then
        print("nut.setCharData SQL Error, q=" .. setQ .. ", Error = " .. sql.LastError())

        return false
    end

    if nut.char.loaded[charIDsafe] then
        nut.char.loaded[charIDsafe]:setData(key, val)
    end

    return true
end

function nut.getCharData(charID, key)
    local charIDsafe = tonumber(charID)
    if not charIDsafe then return end
    local findData = sql.Query("SELECT * FROM nut_characters WHERE _id=" .. charIDsafe)
    if not findData or not findData[1] then return false end
    local data = util.JSONToTable(findData[1]._data) or {}
    if key then return data[key] end

    return data
end

function nut.command.findPlayerSilent(client, name)
    local target = type(name) == "string" and nut.util.findPlayer(name) or NULL

    -- @ to target looking at
    if type(name) == "string" and name == "@" then
        local lookingAt = client:GetEyeTrace().Entity

        if IsValid(lookingAt) and lookingAt:IsPlayer() then
            target = lookingAt
        end
    end

    if IsValid(target) then return target end
end