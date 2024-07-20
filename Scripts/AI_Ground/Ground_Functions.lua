CAP.Ground = {}

function CAP.spawnGround(groupType, country, zoneName, garrison)
    local vars = {}
    local spawnPoint

    repeat
        spawnPoint = mist.getRandomPointInZone(zoneName)
    until(mist.isTerrainValid(spawnPoint, {"LAND"}))

    vars.groupName = "Template_" .. country .. "_" .. groupType
    vars.point = mist.utils.makeVec3(spawnPoint)
    vars.action = 'clone'
    vars.disperse = true
    vars.maxDisp = 100
    vars.anyTerrain = true

    local spawnedGroup = mist.teleportToPoint(vars)

    local spawnedGroupObject = CAP.getAliveGroupLeader(spawnedGroup["name"])

    local spawnedCountry = spawnedGroupObject:getCountry()

    if garrison == true then
        CAP.aliveGroundGroups.Garrison[spawnedGroup["name"]] = spawnedCountry
    else
        CAP.aliveGroundGroups.Assault[spawnedGroup["name"]] = spawnedCountry
    end

    return spawnedGroup["name"]
end

function CAP.Ground.clearZone(groupName, zoneName)
    local zoneUnits = mist.getUnitsInZonesAddedRadius(mist.makeUnitTable({'[all]'}), {zoneName})

    local groupObject = CAP.getAliveGroup(groupName)

    local vec2Veh = groupObject:getUnits()[1]
    local vec2VehPoint = mist.utils.makeVec2(vec2Veh:getPosition().p)

    local controller = groupObject:getController()

    controller:resetTask()

    local enemyPoints = {} -- Vec2
    local totalPoints = {}

    local mission = {}

    for i = 1, #zoneUnits do
        local vars = {}

        vars.action = AI.Task.VehicleFormation.CONE
        vars.speed = 50

        if CAP.getAliveGroupLeader(groupName):getCountry() == 3 and zoneUnits[i]:getCountry() == 47 then
            local unitPoint = mist.utils.makeVec2(zoneUnits[i]:getPosition().p)
            
            vars.x = unitPoint.x
            vars.y = unitPoint.y

            table.insert(enemyPoints, vars)
        end
    end

    totalPoints = {
        [1] = {
            action = AI.Task.VehicleFormation.OFF_ROAD,
            x = vec2VehPoint.x,
            y = vec2VehPoint.y,
            speed = 100,
        },
        [2] = {
            action = AI.Task.VehicleFormation.OFF_ROAD,
            x = vec2VehPoint.x + 11,
            y = vec2VehPoint.y + 11,
            speed = 100,
        },
    }

    if #enemyPoints > 0 then
        for i = 1, #enemyPoints do
            table.insert(totalPoints, enemyPoints[i])
        end

        CAP.msgToAll(mist.utils.tableShow(totalPoints), 5)

        mission = {
            id = 'Mission',
            params = {
                route = {
                    points = totalPoints
                }
            }
        }

        controller:setTask(mission)
    end
end

function CAP.Ground.Go(groupObject, destination) -- If destination is nil then stop at its current position.
    local controller = groupObject:getController()

    controller:resetTask()

    if destination ~= nil then
        -- Build WP --
        -- First point is its own position, Second point is some offset from the first point (No idea why this is needed.)
        -- Third point is its own position but 'on road'
        -- Fourth point is the destination's point but 'on road'
        -- Fifth point is the destination's point
        -- These are all needed for the vehicle to move correctly in 'on road' formation.
        
        local mission = {}

        do
            local vec2DestPoint = mist.utils.makeVec2(trigger.misc.getZone(destination).point)
            local vec2Veh = groupObject:getUnits()[1]
            local vec2VehPoint = mist.utils.makeVec2(vec2Veh:getPosition().p)

            mission = {
                id = 'Mission',
                params = {
                    route = {
                        points = {
                            [1] = {
                                action = AI.Task.VehicleFormation.OFF_ROAD,
                                x = vec2VehPoint.x,
                                y = vec2VehPoint.y,
                                speed = 100,
                            },
                            [2] = {
                                action = AI.Task.VehicleFormation.OFF_ROAD,
                                x = vec2VehPoint.x + 11,
                                y = vec2VehPoint.y + 11,
                                speed = 100,
                            },
                            [3] = {
                                action = AI.Task.VehicleFormation.ON_ROAD,
                                x = vec2VehPoint.x,
                                y = vec2VehPoint.y,
                                speed = 100,
                            },
                            [4] = {
                                action = AI.Task.VehicleFormation.ON_ROAD,
                                x = vec2DestPoint.x,
                                y = vec2DestPoint.y,
                                speed = 100,
                            },
                            [5] = {
                                action = AI.Task.VehicleFormation.OFF_ROAD,
                                x = vec2DestPoint.x,
                                y = vec2DestPoint.y,
                                speed = 100,
                            }
                        }
                    }
                }
            }
        end

        -- Build WP Finish --

        controller:setTask(mission)
    else
        local mission = {}

        do
            local vec2Veh = groupObject:getUnits()[1]
            local vec2VehPoint = mist.utils.makeVec2(vec2Veh:getPosition().p)

            mission = {
                id = 'Mission',
                params = {
                    route = {
                        points = {
                            [1] = {
                                action = AI.Task.VehicleFormation.OFF_ROAD,
                                x = vec2VehPoint.x,
                                y = vec2VehPoint.y,
                                speed = 100,
                            },
                        }
                    }
                }
            }
        end

        controller:setTask(mission)
    end
end