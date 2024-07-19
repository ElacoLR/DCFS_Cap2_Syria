-- 1 : Turkey, 2 : Syria

function CAP.checkZoneOccupation()
    local unitTable = mist.makeUnitTable({'[all]'})
    
    for zoneType, tbl in pairs(CAP.Zones) do
        for zoneName, country in pairs(tbl) do
            local groups = CAP.getGroupsInZone(unitTable, zoneName)

            local countries = {}

            for i = 1, #groups do
                local gL = CAP.getAliveGroupLeader(groups[i])

                local countryEnum = tonumber(gL:getCountry())

                if countries[countryEnum] == nil then
                    countries[countryEnum] = 0
                else
                    countries[countryEnum] = countries[countryEnum] + 1
                end
            end

            if CAP.getTableSize(countries) == 1 then
                if countries[country] == 0 or countries[country] == nil then
                    for k in pairs(countries) do
                        CAP.Zones[zoneType][zoneName] = tonumber(k)
                    end
                end
            end
        end
    end

    CAP.log('Check Zone Occupation complete.')
end
mist.scheduleFunction(CAP.checkZoneOccupation, {}, timer.getTime() + 5, 30)