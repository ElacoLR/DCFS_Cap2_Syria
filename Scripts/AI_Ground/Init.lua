CAP.aliveGroundGroups = {}

function CAP.initGround()
    for zoneType, tbl in pairs(CAP.Zones) do
        for zoneName, country in pairs(tbl) do
            if zoneType == 'Airport' then
                if country == 1 then
                    CAP.spawnGround('Mechanized', 'Turkey', zoneName)
                    CAP.spawnGround('mAA', 'Turkey', zoneName)
                elseif country == 2 then
                    CAP.spawnGround('Mechanized', 'Syria', zoneName)
                    CAP.spawnGround('mAA', 'Syria', zoneName)
                end
            elseif zoneType == 'Airbase' then
                if country == 1 then
                    CAP.spawnGround('Armored', 'Turkey', zoneName)
                    CAP.spawnGround('Mechanized', 'Turkey', zoneName)
                elseif country == 2 then
                    CAP.spawnGround('Armored', 'Syria', zoneName)
                    CAP.spawnGround('Mechanized', 'Syria', zoneName)
                end
            elseif zoneType == 'MilitaryBase' then
                if country == 1 then
                    CAP.spawnGround('Armored', 'Turkey', zoneName)
                    CAP.spawnGround('Mechanized', 'Turkey', zoneName)
                    CAP.spawnGround('mAA', 'Turkey', zoneName)
                elseif country == 2 then
                    CAP.spawnGround('Armored', 'Syria', zoneName)
                    CAP.spawnGround('Mechanized', 'Syria', zoneName)
                    CAP.spawnGround('mAA', 'Syria', zoneName)
                end
            elseif zoneType == 'Factory' then
                if country == 1 then
                    CAP.spawnGround('Motorized', 'Turkey', zoneName)
                    CAP.spawnGround('sAA', 'Turkey', zoneName)
                elseif country == 2 then
                    CAP.spawnGround('Motorized', 'Syria', zoneName)
                    CAP.spawnGround('sAA', 'Syria', zoneName)
                end
            elseif zoneType == 'Outpost' then
                if country == 1 then
                    CAP.spawnGround('Infantry', 'Turkey', zoneName)
                elseif country == 2 then
                    CAP.spawnGround('Infantry', 'Syria', zoneName)
                end
            end
        end
    end

    trigger.action.activateGroup(Group.getByName("Syr_lSAM_Duhur_1"))
    trigger.action.activateGroup(Group.getByName("Syr_lSAM_Kuweires_1"))
    trigger.action.activateGroup(Group.getByName("Turk_lSAM_Incirlik_1"))
    trigger.action.activateGroup(Group.getByName("Turk_EWR_CB23"))
    CAP.aliveGroundGroups["Syr_lSAM_Duhur_1"] = 1
    CAP.aliveGroundGroups["Syr_lSAM_Kuweires_1"] = 1
    CAP.aliveGroundGroups["Turk_lSAM_Incirlik_1"] = 1
    CAP.aliveGroundGroups["Turk_EWR_CB23"] = 1
    CAP.log("initGround complete.")
end
mist.scheduleFunction(CAP.initGround, {}, timer.getTime() + 5)