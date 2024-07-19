-- Set the flag value to country enum.
for zoneType, tbl in pairs(CAP.Zones) do
    for zoneName, country in pairs(tbl) do
        CAP.setFlag(zoneName .. "_country", country)
    end
end