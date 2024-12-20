-- Package Management...
-- Split into air package and ground package.
-- Then split into country?

-- Ground package
-- 1. Key : zone name
-- 2. Value : Tables of package data.
-- 2-1. There can be various package heading for same zone.
-- 3. Finished occupying : remove package.
-- 3.1 Group dead : remove package.

CAP.Package = {}

CAP.Package.Air = {}

CAP.Package.Air.Turkey = {}
CAP.Package.Air.Syria = {}

CAP.Package.Ground = {}

CAP.Package.Air.Active = {}

CAP.Package.Air.Active.Turkey = {}
CAP.Package.Air.Active.Syria = {}

function CAP.refreshPackage()
    for k, v in pairs(CAP.Package.Ground) do
        local packGroup = CAP.getAliveGroup(v.groupName)
        local packGroupL = CAP.getAliveGroupLeader(packGroup)

        if packGroup == nil then -- The group is dead.
            CAP.Package.Ground[k] = nil
        end

        if CAP.getFlag(v.targetZone .. "_country") == tonumber(packGroupL:getCountry()) then
            CAP.Package.Ground[k] = nil
        end
    end

    for country, tbl in pairs(CAP.Package.Air.Active) do
        for id, data in pairs(tbl) do
            if #data.assignedGroupNames > 0 then
                local aliveGroupCount = 0

                for i = 1, #data.assignedGroupNames do
                    if CAP.getAliveGroup(data.assignedGroupNames[i]) then
                        aliveGroupCount = aliveGroupCount + 1
                    end
                end

                if aliveGroupCount < 1 then
                    CAP.Package.Air.Active[country][id] = nil
                end
            else
                CAP.Package.Air.Active[country][id] = nil
            end
        end
    end
end
mist.scheduleFunction(CAP.refreshPackage, {}, timer.getTime() + 5, 600)

function CAP.searchGroundPackage(groupName, targetZone)
    for k, v in pairs(CAP.Package.Ground) do
        if targetZone ~= nil and v.targetZone == targetZone then
            return v.groupName
        end

        if groupName ~= nil and v.groupName == groupName then
            return v.targetZone
        end
    end

    return nil
end

function CAP.createGroundPackage(groupName, targetZone)
    local vars = {}

    vars.groupName = groupName
    vars.targetZone = targetZone

    table.insert(CAP.Package.Ground, vars)
end

function CAP.searchAirPackage(searchType, country, searchFor)
    local count = 0

    for id, data in pairs(CAP.Package.Air[country]) do
        if searchType == 'count' then
            if searchFor == data.missionType then
                count = count + 1
            end
        end

        if searchType == 'target' then
            if searchFor == data.targetGroupName or searchFor == data.targetZoneName then
                return true
            end
        end
    end

    for id, data in pairs(CAP.Package.Air.Active[country]) do
        if searchType == 'count' then
            if searchFor == data.missionType then
                count = count + 1
            end
        end

        if searchType == 'target' then
            if searchFor == data.targetGroupName or searchFor == data.targetZoneName then
                return true
            end
        end
    end

    if searchType == 'count' then
        return count
    end

    if searchType == 'target' then
        return false
    end
end

function CAP.createAirPackage(missionType, country)
    local packageVars = {}
    
    packageVars.id = 0
    repeat
        packageVars.id = math.random(1000, 9999)
    until(CAP.Package.Air[country][packageVars.id] == nil)

    packageVars.country = country
    packageVars.missionType = missionType
    packageVars.assignedPlayers = {}
    packageVars.assignedGroupNames = {}

    if missionType == 'BARCAP' and CAP.searchAirPackage('count', country, missionType) < 4 then
        local selection = {}

        for k, v in pairs(CAP.Zones.MilitaryBase) do
            if country == 'Turkey' and v == 3 then
                table.insert(selection, k)
            elseif country == 'Syria' and v == 47 then
                table.insert(selection, k)
            end
        end

        if #selection > 2 then
            repeat
                table.remove(selection, math.random(1, #selection))
            until(#selection < 3)
        end

        packageVars.orbitPoints = selection

        CAP.Package.Air[country][packageVars.id] = packageVars
    elseif missionType == 'SEAD' and CAP.searchAirPackage('count', country, missionType) < 2 then
        local airbases = {}
        local targetGroups = {}
        
        if country == 'Turkey' then
            for zoneName, countryValue in pairs(CAP.Zones.Airbase) do
                if countryValue == 3 then
                    table.insert(airbases, zoneName)
                end
            end

            local xAvg = 0
            local yAvg = 0

            for i = 1, #airbases do
                local vec2Point = mist.utils.makeVec2(CAP.getZone(airbases[i]).point)
                xAvg = xAvg + vec2Point.x
                yAvg = yAvg + vec2Point.y
            end

            xAvg = xAvg / #airbases
            yAvg = yAvg / #airbases

            local avgPoint = {["x"] = xAvg, ["y"] = yAvg}

            for groupName, _ in pairs(CAP.DetectedTargets.Blue) do
                if CAP.getFlag(groupName .. "_type") == 5 or CAP.getFlag(groupName .. "_type") == 6 then
                    targetGroups[groupName] = CAP.getDistance(avgPoint, CAP.getAliveGroupLeader(groupName):getPosition().p)
                end
            end

            local sortedGroups = CAP.getKeysSortedByValue(targetGroups, function(a, b) return a < b end)

            local iteration = 0
            if #sortedGroups > 0 then
                repeat
                    iteration = iteration + 1
                until(CAP.searchAirPackage('target', country, sortedGroups[iteration]) == false)

                packageVars.targetGroupName = sortedGroups[iteration]

                -- Check if all Search Radars are dead. -> Make it DEAD package.

                local groupUnits = CAP.getAliveGroup(packageVars.targetGroupName):getUnits()

                local srAlive = false

                for idx, data in pairs(groupUnits) do
                    if data:hasAttribute("SAM SR") then
                        srAlive = true
                        break
                    end
                end

                if (srAlive == false) then
                    packageVars.missionType = "DEAD"
                end

                CAP.Package.Air[country][packageVars.id] = packageVars

                CAP.log("SEAD Package Created. Check : CAP.Package.Air")
            end
        elseif country == 'Syria' then
            for zoneName, countryValue in pairs(CAP.Zones.Airbase) do
                if countryValue == 47 then
                    table.insert(airbases, zoneName)
                end
            end

            local xAvg = 0
            local yAvg = 0

            for i = 1, #airbases do
                local vec2Point = mist.utils.makeVec2(CAP.getZone(airbases[i]).point)
                xAvg = xAvg + vec2Point.x
                yAvg = yAvg + vec2Point.y
            end

            xAvg = xAvg / #airbases
            yAvg = yAvg / #airbases
            
            local avgPoint = {["x"] = xAvg, ["y"] = yAvg}

            for groupName, _ in pairs(CAP.DetectedTargets.Red) do
                if CAP.getFlag(groupName .. "_type") == 5 or CAP.getFlag(groupName .. "_type") == 6 then
                    targetGroups[groupName] = CAP.getDistance(avgPoint, CAP.getAliveGroupLeader(groupName):getPosition().p)
                end
            end

            local sortedGroups = CAP.getKeysSortedByValue(targetGroups, function(a, b) return a < b end)

            local iteration = 0

            if #sortedGroups > 0 then
                repeat
                    iteration = iteration + 1
                until(CAP.searchAirPackage('target', country, sortedGroups[iteration]) == false)

                packageVars.targetGroupName = sortedGroups[iteration]

                CAP.Package.Air[country][packageVars.id] = packageVars

                CAP.log("SEAD Package Created. Check : CAP.Package.Air")
            end
        end
    elseif missionType == 'Strike' and CAP.searchAirPackage('count', country, missionType) < 1 then
        local airbases = {}
        local targetZones = {}

        if country == 'Turkey' then
            for zoneName, countryValue in pairs(CAP.Zones.Airbase) do
                if countryValue == 3 then
                    table.insert(airbases, zoneName)
                end
            end

            local xAvg = 0
            local yAvg = 0

            for i = 1, #airbases do
                local vec2Point = mist.utils.makeVec2(CAP.getZone(airbases[i]).point)

                xAvg = xAvg + vec2Point.x
                yAvg = yAvg + vec2Point.y
            end

            xAvg = xAvg / #airbases
            yAvg = yAvg / #airbases

            local avgPoint = {["x"] = xAvg, ["y"] = yAvg}

            for zoneName, countryValue in pairs(CAP.Buildings.Factory) do
                if countryValue == 47 then
                    local zoneDistance = CAP.getDistance(avgPoint, CAP.getZone(zoneName).point)

                    targetZones[zoneName] = zoneDistance
                end
            end

            local sortedZones = CAP.getKeysSortedByValue(targetZones, function(a, b) return a < b end)

            local iteration = 0

            if #sortedGroups > 0 then
                repeat
                    iteration = iteration + 1
                until(CAP.searchAirPackage('target', country, sortedZones[iteration]) == false)

                packageVars.targetZoneName = sortedZones[iteration]

                CAP.Package.Air[country][packageVars.id] = packageVars

                CAP.log("Strike Package created. Check : CAP.Package.Air")
            end
        end
    end

    if missionType == 'BARCAP' then
        CAP.createBARCAP()
    elseif missionType == 'SEAD' then
        CAP.createSEAD()
    elseif missionType == 'Strike' then
        CAP.createStrike()
    end
end

function CAP.createBARCAP()
    local turkEco = CAP.Economy.Turkey
    local syrEco = CAP.Economy.Syria
    local reinforceMultiplier = 15000

    turkEco = mist.utils.round(reinforceMultiplier / turkEco)
    syrEco = mist.utils.round(reinforceMultiplier / syrEco)

    mist.scheduleFunction(CAP.createAirPackage, {'BARCAP', 'Turkey'}, timer.getTime() + turkEco)
    mist.scheduleFunction(CAP.createAirPackage, {'BARCAP', 'Syria'}, timer.getTime() + syrEco)
end
mist.scheduleFunction(CAP.createBARCAP, {}, timer.getTime() + 60)

function CAP.createSEAD()
    local turkEco = CAP.Economy.Turkey
    local syrEco = CAP.Economy.Syria
    local reinforceMultiplier = 20000

    turkEco = mist.utils.round(reinforceMultiplier / turkEco)
    syrEco = mist.utils.round(reinforceMultiplier / syrEco)

    mist.scheduleFunction(CAP.createAirPackage, {'SEAD', 'Turkey'}, timer.getTime() + turkEco)
    mist.scheduleFunction(CAP.createAirPackage, {'SEAD', 'Syria'}, timer.getTime() + syrEco)
end
mist.scheduleFunction(CAP.createSEAD, {}, timer.getTime() + 120)

function CAP.createStrike()
    local turkEco = CAP.Economy.Turkey
    local syrEco = CAP.Economy.Syria
    local reinforceMultiplier = 21000

    turkEco = mist.utils.round(reinforceMultiplier / turkEco)
    syrEco = mist.utils.round(reinforceMultiplier / syrEco)

    mist.scheduleFunction(CAP.createAirPackage, {'Strike', 'Turkey'}, timer.getTime() + turkEco)
    mist.scheduleFunction(CAP.createAirPackage, {'Strike', 'Syria'}, timer.getTime() + syrEco)
end
mist.scheduleFunction(CAP.createStrike, {}, timer.getTime() + 180)