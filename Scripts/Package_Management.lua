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

function CAP.searchGroundPackage(groupName, targetZone)
    for k, v in pairs(CAP.Package.Ground) do
        if targetZone ~= nil and v.targetZone == targetZone then
            return true
        end

        if groupName ~= nil and v.groupName == groupName then
            return true
        end
    end

    return false
end

function CAP.createGroundPackage(groupName, targetZone)
    local vars = {}

    vars.groupName = groupName
    vars.targetZone = targetZone

    table.insert(CAP.Package.Ground, vars)
end