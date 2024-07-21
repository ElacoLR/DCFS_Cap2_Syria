function CAP.createAirCAP(country)
    local groupName = CAP.spawnAir('CAP', country)

    local selection = {}

    for k, v in pairs(CAP.Zones.MilitaryBase) do
        if country == 'Turkey' and v == 3 then
            table.insert(selection, k)
        end
    end

    if #selection > 2 then
        repeat
            table.remove(selection, math.random(1, #selection))
        until(#selection < 3)
    end

    local function assign()
        local groupLeader = Group.getByName(groupName):getUnits()[1]
        local groupLeaderPos = mist.utils.makeVec2(groupLeader:getPosition().p)
        
        local groupController = Group.getByName(groupName):getController()

        local startPoint = CAP.searchNearestVertex(groupLeaderPos)

        local endPoint = CAP.searchNearestVertex(mist.utils.makeVec2(trigger.misc.getZone(selection[math.random(1, 2)]).point))

        local path, _ = ShortestPath(CAP.WaypointsGraph, startPoint, endPoint)

        local points = {}

        if path then
            CAP.log("Shortest path from" .. path[1] .. "to" .. path[#path] .. " : " .. table.concat(path, " -> "))
            for i = 1, #path - 1 do
                local pointVars = {}

                pointVars.type = AI.Task.WaypointType.TURNING_POINT
                pointVars.action = AI.Task.TurnMethod.FLY_OVER_POINT
                pointVars.alt = 25000
                pointVars.alt_type = AI.Task.AltitudeType.BARO
                pointVars.speed = 450
                pointVars.speed_locked = true
                pointVars.x = CAP.Waypoints[path[i]].x
                pointVars.y = CAP.Waypoints[path[i]].y

                if i == 1 then
                    local engageTask = {
                        id = 'EngageTargets',
                        params = {
                            maxDist = 70,
                            targetTypes = {"Fighters", "Interceptors", "Multirole fighters", "Battleplanes"},
                            priority = 1,
                        }
                    }

                    pointVars.task = engageTask
                end

                table.insert(points, pointVars)
            end
        else
            CAP.log("Shortest path error : can not find path.")
            CAP.log("Shortest path error : " .. _)
        end

        local orbitTask = {
            id = 'Orbit',
            params = {
                pattern = AI.Task.OrbitPattern.RACE_TRACK,
                point = mist.utils.makeVec2(trigger.misc.getZone(selection[1]).point),
                point2 = mist.utils.makeVec2(trigger.misc.getZone(selection[2]).point),
                speed = 450,
                altitude = 25000,
            }
        }

        local orbitVars = {}

        orbitVars.type = AI.Task.WaypointType.TURNING_POINT
        orbitVars.action = AI.Task.TurnMethod.FLY_OVER_POINT
        orbitVars.alt = 25000
        orbitVars.alt_type = AI.Task.AltitudeType.BARO
        orbitVars.speed = 450
        orbitVars.speed_locked = true
        orbitVars.x = CAP.Waypoints[path[#path]].x
        orbitVars.y = CAP.Waypoints[path[#path]].y
        orbitVars.task = orbitTask

        table.insert(points, orbitVars)

        local mission = {
            id = 'Mission',
            params = {
                route = {
                    points = points
                }
            }
        }

        groupController:setTask(mission)
    end
    mist.scheduleFunction(assign, {}, timer.getTime() + 10) -- Due to group not being alive in mission immediately after spawning, it needs some delay to actually assign a mission.
end