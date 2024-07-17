CAP.aliveGroundGroups = {}

CAP.aliveGroundGroups.Garrison = {}

CAP.aliveGroundGroups.Assault = {}

function CAP.initGround()
    for zoneType, tbl in pairs(CAP.Zones) do
        for zoneName, country in pairs(tbl) do
            if zoneType == 'Airport' then
                if country == 1 then
                    CAP.spawnGround('Mechanized', 'Turkey', zoneName, true)
                    CAP.spawnGround('mAA', 'Turkey', zoneName, true)
                elseif country == 2 then
                    CAP.spawnGround('Mechanized', 'Syria', zoneName, true)
                    CAP.spawnGround('mAA', 'Syria', zoneName, true)
                end
            elseif zoneType == 'Airbase' then
                if country == 1 then
                    CAP.spawnGround('Armored', 'Turkey', zoneName, true)
                    CAP.spawnGround('Mechanized', 'Turkey', zoneName, true)
                elseif country == 2 then
                    CAP.spawnGround('Armored', 'Syria', zoneName, true)
                    CAP.spawnGround('Mechanized', 'Syria', zoneName, true)
                end
            elseif zoneType == 'MilitaryBase' then
                if country == 1 then
                    CAP.spawnGround('Armored', 'Turkey', zoneName, true)
                    CAP.spawnGround('Mechanized', 'Turkey', zoneName, true)
                    CAP.spawnGround('mAA', 'Turkey', zoneName, true)
                elseif country == 2 then
                    CAP.spawnGround('Armored', 'Syria', zoneName, true)
                    CAP.spawnGround('Mechanized', 'Syria', zoneName, true)
                    CAP.spawnGround('mAA', 'Syria', zoneName, true)
                end
            elseif zoneType == 'Factory' then
                if country == 1 then
                    CAP.spawnGround('Motorized', 'Turkey', zoneName, true)
                    CAP.spawnGround('sAA', 'Turkey', zoneName, true)
                elseif country == 2 then
                    CAP.spawnGround('Motorized', 'Syria', zoneName, true)
                    CAP.spawnGround('sAA', 'Syria', zoneName, true)
                end
            elseif zoneType == 'Outpost' then
                if country == 1 then
                    CAP.spawnGround('Infantry', 'Turkey', zoneName, true)
                elseif country == 2 then
                    CAP.spawnGround('Infantry', 'Syria', zoneName, true)
                end
            end
        end
    end

    trigger.action.activateGroup(Group.getByName("Syr_lSAM_Duhur_1"))
    trigger.action.activateGroup(Group.getByName("Syr_lSAM_Kuweires_1"))
    trigger.action.activateGroup(Group.getByName("Turk_lSAM_Incirlik_1"))
    trigger.action.activateGroup(Group.getByName("Turk_EWR_CB23"))
    trigger.action.activateGroup(Group.getByName("Syr_EWR_DU06"))
    CAP.aliveGroundGroups.Garrison["Syr_lSAM_Duhur_1"] = 1
    CAP.aliveGroundGroups.Garrison["Syr_lSAM_Kuweires_1"] = 1
    CAP.aliveGroundGroups.Garrison["Turk_lSAM_Incirlik_1"] = 1
    CAP.aliveGroundGroups.Garrison["Turk_EWR_CB23"] = 1
    CAP.aliveGroundGroups.Garrison["Syr_EWR_DU06"] = 1
    CAP.log("initGround complete.")
end
mist.scheduleFunction(CAP.initGround, {}, timer.getTime() + 5)