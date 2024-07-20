CAP.Air = {}

function CAP.spawnAir(groupType, country)
    local vars = {}

    vars.groupName = CAP.Template.Air[country][groupType][math.random(1, #CAP.Template.Air[country][groupType])]
    vars.action = 'clone'

    local spawnedGroup = mist.teleportToPoint(vars)

    local spawnedCountry

    if country == 'Turkey' then
        spawnedCountry = 3
    elseif country == 'Syria' then
        spawnedCountry = 47
    end

    CAP.aliveAirGroups[spawnedGroup["name"]] = 1

    return spawnedGroup["name"]
end

function CAP.assignTaskToAir(groupName) -- Event handler take off -> assign task.

end