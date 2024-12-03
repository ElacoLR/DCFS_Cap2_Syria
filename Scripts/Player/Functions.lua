function CAP.playerBriefing(pkg)
    local pkgNum = pkg.id

    for i = 1, #pkg.assignedGroupNames do
        local gID = Group.getByName(pkg.assignedGroupNames[i]):getID()

        CAP.msg(gID, '', 120)
    end
end

function CAP.assignPlayerMission(groupData)
    local unit = CAP.getAliveGroupLeader(groupData:getName())

    local country = unit:getCountry()

    local pkg = CAP.getRandomFromTable(CAP.Package.Air[country])

    table.insert(pkg.assignedPlayers, unit:getPlayerName())
    table.insert(pkg.assignedGroupNames, groupData:getName())

    CAP.Package.Air.Active[country][pkg.id] = mist.utils.deepCopy(pkg)
    CAP.Package.Air[country][pkg.id] = nil

    -- Generate waypoints

    local pathPoints = {}

    local groupLeaderPos = mist.utils.makeVec2(unit:getPosition().p)

    local targetGroupLeader = CAP.getAliveGroupLeader(pkg.targetGroupName)

    local startPoint = CAP.searchNearestVertex(groupLeaderPos)
    local endPoint = CAP.searchNearestVertex(mist.utils.makeVec2(targetGroupLeader:getPosition().p))

    local path, _ = ShortestPath(CAP.WaypointsGraph, startPoint, endPoint)

    if path then
        for i = #path, 1, -1 do -- Check for distance between point and target SAM. (40nm)
            local pathPoint = {["x"] = CAP.Waypoints[path[i]].x, ["y"] = CAP.Waypoints[path[i]].y}

            if CAP.getDistance(pathPoint, mist.utils.makeVec2(targetGroupLeader:getPosition().p)) < mist.utils.NMToMeters(40) then
                table.remove(path, i)
            end
        end

        for i = 1, #path - 1 do
            local pointVars = {}

            pointVars.x = CAP.Waypoints[path[i]].x
            pointVars.y = CAP.Waypoints[path[i]].y

            table.insert(pathPoints, pointVars)
        end
    else
        CAP.log("Shortest path error : can not find path.")
        CAP.log("Shortest path error : " .. _)
    end

    pkg['points'] = pathPoints
end

function CAP.invitePlayer(groupData, playerName)

end