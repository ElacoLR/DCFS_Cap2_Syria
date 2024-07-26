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

function CAP.getTableSize(tbl)
    local size = 0

    for k, v in pairs(tbl) do
        size = size + 1
    end

    return size
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
        p1 = CAP.getZone(p1).point
    end

    if type(p2) == 'string' then
        p2 = CAP.getZone(p2).point
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

function CAP.getAliveGroupLeader(g)
    if g == nil then
        return nil
    end

    local group = g

    if type(g) == 'string' then
        group = CAP.getAliveGroup(g)
    end

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

function CAP.getGroupsInZone(unit_names, zone_names, zone_type)
    zone_type = zone_type or 'cylinder'
    if zone_type == 'c' or zone_type == 'cylindrical' or zone_type == 'C' then
        zone_type = 'cylinder'
    end
    if zone_type == 's' or zone_type == 'spherical' or zone_type == 'S' then
        zone_type = 'sphere'
    end

    assert(zone_type == 'cylinder' or zone_type == 'sphere', 'invalid zone_type: ' .. tostring(zone_type))

    local groups = {}
    local groups_idx = {}
    local zones = {}

    if zone_names and type(zone_names) == 'string' then
        zone_names = {zone_names}
    end

    for k = 1, #unit_names do
        if CAP.getAliveUnit(unit_names[k]) then
            local group = CAP.getAliveUnit(unit_names[k]):getGroup()
            if CAP.getAliveGroup(group:getName()) and not groups[group:getName()] then
                groups[group:getName()] = true
                table.insert(groups_idx, group:getName())
            end
        end
    end

    for k = 1, #zone_names do
        local zone = mist.DBs.zonesByName[zone_names[k]]
        if zone then
            zones[#zones + 1] = {radius = zone.radius, x = zone.point.x, y = zone.point.y, z = zone.point.z, verts = zone.verticles}
        end
    end

    local in_zone_groups = {}

    for groups_ind = 1, #groups_idx do
        local lUnit = CAP.getAliveGroupLeader(groups_idx[groups_ind])
        local unit_pos = lUnit:getPosition().p
        local lCat = lUnit:getCategory()

        for zones_ind = 1, #zones do
            if zone_type == 'sphere' then
                local alt = land.getHeight({x = zones[zones_ind].x, y = zones[zones_ind].z})
                if alt then
                    zones[zones_ind].y = alt
                end
            end

            if unit_pos and ((lCat == 1 and lUnit:isActive() == true) or lCat ~= 1) then
                if zones[zones_ind].verts then
                    if mist.pointInPolygon(unit_pos, zones[zones_ind].verts) then
                        in_zone_groups[#in_zone_groups + 1] = lUnit:getGroup()
                    end
                else
                    if zone_type == 'cylinder' and (((unit_pos.x - zones[zones_ind].x)^2 + (unit_pos.z - zones[zones_ind].z)^2)^0.5 <= zones[zones_ind].radius) then
                        in_zone_groups[#in_zone_groups + 1] = lUnit:getGroup()
                        break
                    elseif zone_type == 'sphere' and (((unit_pos.x - zones[zones_ind].x)^2 + (unit_pos.y - zones[zones_ind].y)^2 + (unit_pos.z - zones[zones_ind].z)^2)^0.5 <= zones[zones_ind].radius) then
                        in_zone_groups[#in_zone_groups + 1] = lUnit:getGroup()
                        break
                    end
                end
            end
        end
    end

    return in_zone_groups
end

function CAP.isInZone(unit, zoneName) -- assume that zone is circle.
    local unitObject = unit

    if type(unitObject) == 'string' then
        unitObject = CAP.getAliveUnit(unit)
    end

    local unitPoint = mist.utils.makeVec2(unitObject:getPosition().p)

    local zone = CAP.getZone(zoneName)

    local zonePoint = zone.point

    if CAP.getDistance(unitPoint, zonePoint) < zone.radius then
        return true
    end

    return false
end