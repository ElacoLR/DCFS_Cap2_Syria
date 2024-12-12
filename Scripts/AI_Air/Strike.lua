function CAP.createAirStrike(country, targetZoneName)
    local groupName = CAP.spawnAir('Strike', country)

    local groupLeader = Group.getByName(groupName):getUnits()[1]
    local groupLeaderPos = mist.utils.makeVec2(groupLeader:getPosition().p)

    local groupController = Group.getByName(groupName):getController()

    local startPoint = CAP.searchNearestVertex(groupLeaderPos)
    local endPoint = CAP.searchNearestVertex(mist.utils.makeVec2(CAP.getZone(targetZoneName).point))

    local path, _ = ShortestPath(CAP.WaypointsGraph, startPoint, endPoint)

    local points = {}

    local engageTask = {}

    local targetZone = CAP.getZone(targetZoneName)

    -- Iterate through path, check for near enemy SAM. If closer than X nm (S-300 Range) return false.
    -- -> Clear the package.
    
    if path then
        for i = #path, 1, -1 do
            local pathPoint = {["x"] = CAP.Waypoints[path[i]].x, ["y"] = CAP.Waypoints[path[i]].y}

            if country == 'Turkey' then
                for enemySAM, _ in pairs(CAP.DetectedTargets.Blue) do
                    if CAP.getFlag(enemySAM .. "_type") == 5 or CAP.getFlag(enemySAM .. "_type") == 6 then
                        local dist = CAP.getDistance(pathPoint, mist.utils.makeVec2(CAP.getAliveGroupLeader(enemySAM):getPosition().p))

                        if dist < mist.utils.NMToMeters(70) then -- Adjust to S-300 Effective Range.
                            return false
                        end

                        if dist < mist.utils.NMToMeters(40) then
                            table.remove(path, i)
                        end
                    end
                end
            elseif country == 'Syria' then
                for enemySAM, _ in pairs(CAP.DetectedTargets.Red) do
                    if CAP.getFlag(enemySAM .. "_type") == 5 or CAP.getFlag(enemySAM .. "_type") == 6 then
                        local dist = CAP.getDistance(pathPoint, mist.utils.makeVec2(CAP.getAliveGroupLeader(enemySAM):getPosition().p))

                        if dist < mist.utils.NMToMeters(100) then -- Adjust to Hawk Effective Range.
                            return false
                        end

                        if dist < mist.utils.NMToMeters(40) then
                            table.remove(path, i)
                        end
                    end
                end
            end
        end

        for i = 1, #path - 1 do
            local pointVars = {}

            pointVars.type = AI.Task.WaypointType.TURNING_POINT
            pointVars.action = AI.Task.TurnMethod.FLY_OVER_POINT
            pointVars.alt = mist.utils.feetToMeters(30000)
            pointVars.alt_type = AI.Task.AltitudeType.BARO
            pointVars.speed = mist.utils.knotsToMps(450)
            pointVars.speed_locked = true
            pointVars.x = CAP.Waypoints[path[i]].x
            pointVars.y = CAP.Waypoints[path[i]].y

            table.insert(points, pointVars)
        end
    else
        CAP.log("Shortest path error : can not find path.")
        CAP.log("Shortest path error : " .. _)
    end

    local bombingTask = {
        id = 'Bombing',
        params = {
            point = mist.utils.makeVec2(targetZone.point),
            expend = "All",
            attackQty = 1,
            attackQtyLimit = true,
            groupAttack = true,
        }
    }

    local engageVars = {}

    engageVars.type = AI.Task.WaypointType.TURNING_POINT
    engageVars.action = AI.Task.TurnMethod.FLY_OVER_POINT
    engageVars.alt = mist.utils.feetToMeters(30000)
    engageVars.alt_type = AI.Task.AltitudeType.BARO
    engageVars.speed = mist.utils.knotsToMps(450)
    engageVars.speed_locked = true
    engageVars.x = CAP.Waypoints[path[#path]].x
    engageVars.y = CAP.Waypoints[path[#path]].y
    engageVars.task = bombingTask

    table.insert(points, engageVars)

    local controlledTask = {
        id = 'ControlledTask',
        params = {
            task = {
                id = 'Mission',
                params = {
                    airborne = true,
                    route = {
                        points = points,
                    }
                }
            },
            condition = {
                probability = 100,
            },
            stopCondition = {

            },
        }
    }
    CAP.listMission(groupName, controlledTask)
    CAP.log("Mission is listed : SEAD")
    return groupName
end