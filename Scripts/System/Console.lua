--[[local path, cost = ShortestPath(CAP.WaypointsGraph, 152, 66)

if path then
    CAP.msgToAll("Shortest path from 152 to 66 : " .. table.concat(path, " -> "), 1)
    print("total cost : " .. cost)
else
    CAP.msgToAll(cost, 1) -- No path found
end]]

--[[
local objID = 0

for factoryName in pairs(CAP.Buildings.Factory) do
    for k, v in pairs(env.mission.triggers.zones) do
        local zone = mist.utils.deepCopy(v)
    
        if zone.name == factoryName then
            objID = zone.properties[3]["value"]
            break
        end
    end

    local objectTbl = {  ["id_"] = objID,}

    if Object.isExist(objectTbl) then
        CAP.msgToAll("Building exist.\n" .. Object.getName(objectTbl), 5)
    else
        CAP.msgToAll("Building doesn't exist.", 5)
    end
end
]]

-- CAP.groundReinforce('Turkey')
CAP.msgToAll(tostring(CAP.getFlag('Outpost_BA97_country')), 5)