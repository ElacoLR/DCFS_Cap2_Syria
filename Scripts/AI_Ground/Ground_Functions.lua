function CAP.spawnGround(groupType, country, zoneName)
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

    CAP.aliveGroundGroups[spawnedGroup["name"]] = 1

    return spawnedGroup["name"]
end