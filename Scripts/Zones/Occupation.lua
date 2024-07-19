-- 1 : Turkey, 2 : Syria

function CAP.checkZoneOccupation()
    for zoneType, tbl in pairs(CAP.Zones) do
        for zoneName, country in pairs(tbl) do
            local groups = CAP.getGroupsInZone(zoneName)

            local countries = {}

            for i = 1, #groups do
                local gL = CAP.getAliveGroupLeader(groups[i])

                local countryEnum = gL:getCountry()

                countries[countryEnum] = countries[countryEnum] + 1
            end

            if CAP.getTableSize(countries) == 1 and countries[country] == nil then
                for k in pairs(countries) do
                    CAP.Zones[zoneType][zoneName] = tonumber(k)
                end
            end
        end
    end
end
mist.scheduleFunction(CAP.checkZoneOccupation, {}, timer.getTime() + 5, 600)