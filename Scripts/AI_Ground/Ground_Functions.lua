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
    vars.anyTerrain = true

    local spawnedGroup = mist.teleportToPoint(vars)

    if garrison == true then
        CAP.aliveGroundGroups.Garrison[spawnedGroup["name"]] = 1
    else
        CAP.aliveGroundGroups.Assault[spawnedGroup["name"]] = 1
    end

    return spawnedGroup["name"]
end