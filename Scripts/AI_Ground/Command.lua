-- 1. Get alive groups from CAP.aliveGroundGroups.Assault (k : group name, v : 1 if alive)
-- 2. Get coalition.
-- 3. Get opposing zones and sort by distance from its leader unit.
-- 4. Send to the nearest zone.

function CAP.newCommand()
    for groupName, _ in pairs(CAP.aliveGroundGroups.Assault) do
        if CAP.searchGroundPackage(groupName, nil) == false then
            local coal = CAP.getAliveGroup(groupName):getCoalition()

            local targetZones = {}

            local group = CAP.getAliveGroup(groupName)
            local groupLeader = CAP.getAliveGroupLeader(groupName)

            for __, tbl in pairs(CAP.Zones) do
                for zoneName, country in pairs(tbl) do
                    if coal == 2 and country == 2 then -- blue team (opposing zone : 2, ...)
                        targetZones[zoneName] = CAP.getDistance(groupLeader:getPosition().p, trigger.misc.getZone(zoneName).point)
                    end
                end
            end

            CAP.msgToAll(tostring(#targetZones), 1)

            local sortedDests = CAP.getKeysSortedByValue(targetZones, function(a, b) return a < b end)

            CAP.msgToAll(tostring(#sortedDests), 1)

            for _, key in pairs(sortedDests) do
                if CAP.searchGroundPackage(nil, key) == false then
                    CAP.Ground.Go(group, key)
                    CAP.createGroundPackage(groupName, key)
                    break
                end
            end
        end
    end

    CAP.msgToAll("new Command executed.", 5)
end
mist.scheduleFunction(CAP.newCommand, {}, timer.getTime() + 1, 300)