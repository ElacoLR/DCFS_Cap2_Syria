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

    for id, data in pairs(CAP.Package.Air.Active['Turkey']) do
        if #data.assignedGroupNames > 0 then
            local aliveGroupCount = 0

            for i = 1, #data.assignedGroupNames do
                if CAP.getAliveGroup(data.assignedGroupNames[i]) then
                    aliveGroupCount = aliveGroupCount + 1
                end
            end

            if aliveGroupCount < 1 then
                CAP.Package.Air.Active['Turkey'][id] = nil
            end
        else
            CAP.Package.Air.Active['Turkey'][id] = nil
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
    end

    for id, data in pairs(CAP.Package.Air.Active[country]) do
        if searchType == 'count' then
            if searchFor == data.missionType then
                count = count + 1
            end
        end
    end

    if searchType == 'count' then
        return count
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

        packageVars.assignedPlayers = {}

        packageVars.assignedGroupNames = {}

        CAP.Package.Air[country][packageVars.id] = packageVars
    end
    CAP.createBARCAP()
end

function CAP.createBARCAP()
    local turkEco = CAP.Economy.Turkey
    local syrEco = CAP.Economy.Syria
    local reinforceMultiplier = 5000

    turkEco = mist.utils.round(reinforceMultiplier / turkEco)
    syrEco = mist.utils.round(reinforceMultiplier / syrEco)

    mist.scheduleFunction(CAP.createAirPackage, {'BARCAP', 'Turkey'}, timer.getTime() + turkEco)
    mist.scheduleFunction(CAP.createAirPackage, {'BARCAP', 'Syria'}, timer.getTime() + syrEco)
end
mist.scheduleFunction(CAP.createBARCAP, {}, timer.getTime() + 60)