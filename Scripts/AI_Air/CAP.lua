function CAP.createAirCAP(country)
    local groupName = CAP.spawnAir('CAP', country)

    -- local groupLeader = CAP.getAliveGroupLeader(groupName)
    -- local groupLeaderPos = mist.utils.makeVec2(groupLeader:getPosition().p)

    local function doIt()
        local groupLeader = Group.getByName(groupName):getUnits()[1]
        local groupLeaderPos = mist.utils.makeVec2(groupLeader:getPosition().p)
    
        -- Todo : Figure out how to search the nearest vertex in the waypoints graph.
    end
    mist.scheduleFunction(doIt, {}, timer.getTime() + 10)
end