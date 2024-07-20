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
CAP.Package.Ground = {}

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

    for k, v in pairs(CAP.Package.Air) do

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

function CAP.createAirCAPData(country)
    local bases = {}
    local selectedBases = {}

    for k, v in pairs(CAP.Zones.MilitaryBase) do
        if country == 'Turkey' and v == 3 then
            table.insert(bases, k)
        end
    end

    local randomKey = math.random(1, #bases)
    table.insert(selectedBases, bases[randomKey])
    table.remove(bases, randomKey)
    randomKey = math.random(1, #bases)
    table.insert(selectedBases, bases[randomKey])

    local vec2Point1 = mist.utils.makeVec2(trigger.misc.getZone(selectedBases[1]).point)
    local vec2Point2 = mist.utils.makeVec2(trigger.misc.getZone(selectedBases[2]).point)

    local vars = {}
    local orbitTask = {
        id = 'Orbit',
        params = {
            pattern = AI.Task.OrbitPattern.RACE_TRACK,
            point = vec2Point1,
            point2 = vec2Point2,
            speed = 450,
            altitude = 30000,
        }
    }

    vars.type = AI.Task.WaypointType.TURNING_POINT
    vars.action = AI.Task.TurnMethod.FLY_OVER_POINT
    vars.x = vec2Point.x
    vars.y = vec2Point.y
    vars.alt = 30000
    vars.speed = 450
    vars.speed_locked = true
    vars.task = orbitTask

    return vars
end