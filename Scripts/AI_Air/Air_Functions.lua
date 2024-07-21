CAP.Air = {}

function CAP.spawnAir(groupType, country)
    local vars = {}

    vars.groupName = CAP.Template.Air[country][groupType][math.random(1, #CAP.Template.Air[country][groupType])]
    vars.action = 'clone'

    local spawnedGroup = mist.teleportToPoint(vars)

    CAP.aliveAirGroups[spawnedGroup["name"]] = 1

    return spawnedGroup["name"]
end