function CAP.createAirCAP(country, orbitPoints)
    local groupName = CAP.spawnAir('CAP', country)

    local groupLeader = Group.getByName(groupName):getUnits()[1]
    local groupLeaderPos = mist.utils.makeVec2(groupLeader:getPosition().p)
    
    local groupController = Group.getByName(groupName):getController()

    local startPoint = CAP.searchNearestVertex(groupLeaderPos)

    local endPoint = CAP.searchNearestVertex(mist.utils.makeVec2(CAP.getZone(orbitPoints[math.random(1, 2)]).point))

    local path, _ = ShortestPath(CAP.WaypointsGraph, startPoint, endPoint)

    local points = {}

    local engageTask = {}

    local pathAlt = math.random(25, 30) * 1000

    if path then
        for i = 1, #path - 1 do
            local pointVars = {}

            pointVars.type = AI.Task.WaypointType.TURNING_POINT
            pointVars.action = AI.Task.TurnMethod.FLY_OVER_POINT
            pointVars.alt = mist.utils.feetToMeters(pathAlt)
            pointVars.alt_type = AI.Task.AltitudeType.BARO
            pointVars.speed = mist.utils.knotsToMps(450)
            pointVars.speed_locked = true
            pointVars.x = CAP.Waypoints[path[i]].x
            pointVars.y = CAP.Waypoints[path[i]].y

            if i == 1 then
                engageTask = {
                    id = 'EngageTargets',
                    params = {
                        maxDist = mist.utils.NMToMeters(50),
                        maxDistEnabled = true,
                        targetTypes = {"Planes"},
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
            point = mist.utils.makeVec2(CAP.getZone(orbitPoints[1]).point),
            point2 = mist.utils.makeVec2(CAP.getZone(orbitPoints[2]).point),
            speed = mist.utils.knotsToMps(450),
            altitude = mist.utils.feetToMeters(pathAlt),
        }
    }

    local orbitVars = {}

    orbitVars.type = AI.Task.WaypointType.TURNING_POINT
    orbitVars.action = AI.Task.TurnMethod.FLY_OVER_POINT
    orbitVars.alt = mist.utils.feetToMeters(pathAlt)
    orbitVars.alt_type = AI.Task.AltitudeType.BARO
    orbitVars.speed = mist.utils.knotsToMps(450)
    orbitVars.speed_locked = true
    orbitVars.x = CAP.Waypoints[path[#path]].x
    orbitVars.y = CAP.Waypoints[path[#path]].y
    orbitVars.task = orbitTask

    table.insert(points, orbitVars)

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

    return groupName
end