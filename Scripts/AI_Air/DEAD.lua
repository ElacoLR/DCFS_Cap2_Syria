function CAP.createAirDEAD(country, targetGroupName)
    local groupName = CAP.spawnAir('DEAD', country)

    local groupLeader = Group.getByName(groupName):getUnits()[1]
    local groupLeaderPos = mist.utils.makeVec2(groupLeader:getPosition().p)

    local groupController = Group.getByName(groupName):getController()

    local startPoint = CAP.searchNearestVertex(groupLeaderPos)
    local endPoint = CAP.searchNearestVertex(mist.utils.makeVec2(CAP.getAliveGroupLeader(targetGroupName):getPosition().p))

    local path, _ = ShortestPath(CAP.WaypointsGraph, startPoint, endPoint)

    local points = {}

    local engageTask = {}

    local targetGroup = CAP.getAliveGroup(targetGroupName)
    local targetGroupLeader = CAP.getAliveGroupLeader(targetGroupName)

    if path then
        for i = #path, 1, -1 do -- Check for distance between point and target SAM. (40nm)
            local pathPoint = {["x"] = CAP.Waypoints[path[i]].x, ["y"] = CAP.Waypoints[path[i]].y}

            if CAP.getDistance(pathPoint, mist.utils.makeVec2(targetGroupLeader:getPosition().p)) < mist.utils.NMToMeters(40) then
                table.remove(path, i)
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

    -- Assign SAM units to engage.

    local targets = {}

    local targetUnits = targetGroup:getUnits()

    local anyFound = false

    local firstTargetPoint

    for i = 1, #targetUnits do
        if targetUnits[i]:hasAttribute("SAM related") then
            targets[targetUnits[i]:getName()] = targetUnits[i]:getID()

            firstTargetPoint = mist.utils.makeVec2(targetUnits[i]:getPosition().p)

            anyFound = true
        end
    end

    local tasks = {}
    local attackTask = {}

    if anyFound == true then
        for tName, tId in pairs(targets) do
            attackTask = {
                id = 'AttackGroup',
                params = {
                    groupId = Unit.getByName(tName):getGroup():getID(),
                    weaponType = 2147485694,
                    groupAttack = true,
                    attackQtyLimit = true,
                    attackQty = 100,
                }
            }
            CAP.log("assigned : " .. tName)

            break
        end
    end

    local engageVars = {}

    engageVars.type = AI.Task.WaypointType.TURNING_POINT
    engageVars.action = AI.Task.TurnMethod.FLY_OVER_POINT
    engageVars.alt = mist.utils.feetToMeters(30000)
    engageVars.alt_type = AI.Task.AltitudeType.BARO
    engageVars.speed = mist.utils.knotsToMps(450)
    engageVars.speed_locked = true
    engageVars.x = firstTargetPoint.x
    engageVars.y = firstTargetPoint.y
    engageVars.task = attackTask

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
    CAP.log("Mission is listed : DEAD")
    return groupName
end