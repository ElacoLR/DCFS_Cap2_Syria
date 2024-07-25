CAP.Air = {}

CAP.missionList = {}

function CAP.spawnAir(groupType, country)
    local vars = {}

    vars.groupName = CAP.Template.Air[country][groupType][math.random(1, #CAP.Template.Air[country][groupType])]
    vars.action = 'clone'

    local spawnedGroup = mist.teleportToPoint(vars)

    CAP.aliveAirGroups[spawnedGroup["name"]] = 1

    local function setROE()
        local controller = Group.getByName(spawnedGroup["name"]):getController()

        controller:setOption(AI.Option.Air.id.ROE, AI.Option.Air.val.ROE.OPEN_FIRE_WEAPON_FREE)
    end

    mist.scheduleFunction(setROE, {}, timer.getTime() + 2) -- Possibly move to take off event.

    return spawnedGroup["name"]
end

function CAP.listMission(groupName, mission)
    CAP.missionList[groupName] = mission
end