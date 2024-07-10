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