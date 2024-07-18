CAP = {} -- Do NOT Remove !

function string:split(delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = string.find(self, delimiter, from)
    
    while delim_from do
        table.insert(result, string.sub(self, from, delim_from-1))
        from = delim_to + 1
        delim_from, delim_to = string.find(self, delimiter, from)
    end
    
    table.insert(result, string.sub(self, from))
    
    return result
end

function CAP.log(log)
    env.info("DCFS_CAP2_Syria LOG : " .. log)
end

function CAP.setFlag(flagName, flagValue)
    return trigger.action.setUserFlag(flagName, flagValue)
end

function CAP.getFlag(flagName)
    return trigger.misc.getUserFlag(flagName)
end

function CAP.msg(gID, text, duration)
    trigger.action.outTextForGroup(gID, '[ ◆ System ◆ ]\n\n' .. text, duration)
end

function CAP.cleanMsg(gID, text, duration)
    trigger.action.outTextForGroup(gID, '[ ◆ System ◆ ]\n\n' .. text, duration, true)
end

function CAP.msgToAll(text, duration)
    trigger.action.outText('[ ◆ System ◆ ]\n\n' .. text, duration)
end

function CAP.cleanMsgToAll(text, duration)
    trigger.action.outText('[ ◆ System ◆ ]\n\n' .. text, duration, true)
end

function CAP.getZone(zoneName)
    return trigger.misc.getZone(zoneName)
end

function CAP.getDistance(p1, p2)
    local p1x, p1y, p2x, p2y

    if type(p1) == 'string' then
        p1 = trigger.misc.getZone(p1).point
    end

    if type(p2) == 'string' then
        p2 = trigger.misc.getZone(p2).point
    end

    if p1.z then
        p1y = p1.z
    else
        p1y = p1.y
    end

    if p2.z then
        p2y = p2.z
    else
        p2y = p2.y
    end

    p1x = p1.x
    p2x = p2.x

    local xDiff = p1x - p2x
    local yDiff = p1y - p2y

    return math.floor(math.sqrt(xDiff * xDiff + yDiff * yDiff) + 0.5)
end

function CAP.getKeysSortedByValue(tbl, sortFunction)
    local keys = {}

    for k in pairs(tbl) do
        table.insert(keys, k)
    end

    table.sort(keys, function(a, b)
        return sortFunction(tbl[a], tbl[b])
    end)

    return keys
end

function CAP.getAliveUnit(unitName)
    if unitName == nil then
        return nil
    end

    local unit = Unit.getByName(unitName)

    if unit ~= nil and unit:isActive() and unit:getLife() > 1.0 then
        return unit
    end
    
    return nil
end

function CAP.getAliveGroup(groupName)
    if groupName == nil then
        return nil
    end

    local group = Group.getByName(groupName)

    if group ~= nil then
        local groupUnits = Group.getUnits(group)

        if #groupUnits > 0 then
            for i = 1, #groupUnits do
                local unit = groupUnits[i]

                if unit ~= nil and unit:isActive() and unit:getLife() > 1.0 then
                    return group
                end
            end
        else
            return nil
        end
    else
        return nil
    end
end

function CAP.getAliveGroupLeader(groupName)
    if groupName == nil then
        return nil
    end

    local group = CAP.getAliveGroup(groupName)

    if group ~= nil then
        local groupUnits = Group.getUnits(group)

        if #groupUnits > 0 then
            local leaderExist = false
            local leaderIter

            for i = 1, #groupUnits do
                local unit = groupUnits[i]

                if unit ~= nil and unit:isActive() and unit:getLife() > 1.0 then
                    leaderExist = true
                    leaderIter = i
                    break
                end
            end

            if leaderExist == true then
                return groupUnits[leaderIter]
            else
                return nil
            end
        else
            return nil
        end
    else
        return nil
    end
end