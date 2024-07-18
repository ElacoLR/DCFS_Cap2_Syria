-- 1 : Turkey, 2 : Syria

function CAP.checkZoneOccupation()
    for _, tbl in pairs(CAP.Zones) do
        for zoneName, country in pairs(tbl) do
            local groups = CAP.getGroupsInZone(zoneName)

            local countries = {}
        end
    end
end