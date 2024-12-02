function CAP.checkEconomy()
    CAP.Economy.Turkey = 0
    CAP.Economy.Syria = 0

    for factoryName, country in pairs(CAP.Buildings.Factory) do
        for _, v in pairs(env.mission.triggers.zones) do
            local zone = mist.utils.deepCopy(v)

            if zone.name == factoryName then
                objID = zone.properties[3]["value"]
                break
            end
        end

        local objTbl = {["id_"] = objID,}

        if Object.isExist(objTbl) then
            if country == 3 then
                CAP.Economy.Turkey = CAP.Economy.Turkey + 1
            elseif country == 47 then
                CAP.Economy.Syria = CAP.Economy.Syria + 1
            end
        end
    end
end

function CAP.incEconomy(country, value)
    CAP.Economy[country] = CAP.Economy[country] + value
end

function CAP.decEconomy(country, value)
    CAP.Economy[country] = CAP.Economy[country] - value
end