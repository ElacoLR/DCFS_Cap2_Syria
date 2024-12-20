CAP.aliveGroundGroups = {}

CAP.aliveGroundGroups.Garrison = {}

CAP.aliveGroundGroups.Assault = {}

function CAP.initGround()
    for zoneType, tbl in pairs(CAP.Zones) do
        for zoneName, country in pairs(tbl) do
            if zoneType == 'Airport' then
                if country == 3 then
                    CAP.spawnGround('Mechanized', 'Turkey', zoneName, true)
                    CAP.spawnGround('mAA', 'Turkey', zoneName, true)
                elseif country == 47 then
                    CAP.spawnGround('Mechanized', 'Syria', zoneName, true)
                    CAP.DetectedTargets.Blue[CAP.spawnGround('mAA', 'Syria', zoneName, true)] = 1
                end
            elseif zoneType == 'Airbase' then
                if country == 3 then
                    CAP.spawnGround('Armored', 'Turkey', zoneName, true)
                    CAP.spawnGround('Mechanized', 'Turkey', zoneName, true)
                elseif country == 47 then
                    CAP.spawnGround('Armored', 'Syria', zoneName, true)
                    CAP.spawnGround('Mechanized', 'Syria', zoneName, true)
                end
            elseif zoneType == 'MilitaryBase' then
                if country == 3 then
                    CAP.spawnGround('Armored', 'Turkey', zoneName, true)
                    CAP.spawnGround('Mechanized', 'Turkey', zoneName, true)
                    CAP.spawnGround('mAA', 'Turkey', zoneName, true)
                elseif country == 47 then
                    CAP.spawnGround('Armored', 'Syria', zoneName, true)
                    CAP.spawnGround('Mechanized', 'Syria', zoneName, true)
                    CAP.DetectedTargets.Blue[CAP.spawnGround('mAA', 'Syria', zoneName, true)] = 1
                end
            elseif zoneType == 'Factory' then
                if country == 3 then
                    CAP.spawnGround('Motorized', 'Turkey', zoneName, true)
                    CAP.spawnGround('sAA', 'Turkey', zoneName, true)
                elseif country == 47 then
                    CAP.spawnGround('Motorized', 'Syria', zoneName, true)
                    CAP.spawnGround('sAA', 'Syria', zoneName, true)
                end
            elseif zoneType == 'Outpost' then
                if country == 3 then
                    CAP.spawnGround('Infantry', 'Turkey', zoneName, true)
                elseif country == 47 then
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
    trigger.action.activateGroup(Group.getByName("Syr_lSAM_Jirah_1"))
    trigger.action.activateGroup(Group.getByName("Turk_lSAM_Sanliurfa_1"))
    trigger.action.activateGroup(Group.getByName("Syr_lSAM_Tabqa_1"))
    trigger.action.activateGroup(Group.getByName("Syr_lSAM_Tiyas_1"))
    trigger.action.activateGroup(Group.getByName("Syr_lSAM_Hama_1"))
    CAP.aliveGroundGroups.Garrison["Syr_lSAM_Duhur_1"] = 1
    CAP.setFlag("Syr_lSAM_Duhur_1" .. "_type", 6)
    CAP.aliveGroundGroups.Garrison["Syr_lSAM_Kuweires_1"] = 1
    CAP.setFlag("Syr_lSAM_Kuweires_1" .. "_type", 6)
    CAP.aliveGroundGroups.Garrison["Turk_lSAM_Incirlik_1"] = 1
    CAP.setFlag("Turk_lSAM_Incirlik_1" .. "_type", 6)
    CAP.aliveGroundGroups.Garrison["Turk_EWR_CB23"] = 1
    CAP.setFlag("Turk_EWR_CB23" .. "_type", 8)
    CAP.aliveGroundGroups.Garrison["Syr_EWR_DU06"] = 1
    CAP.setFlag("Syr_EWR_DU06" .. "_type", 8)
    CAP.aliveGroundGroups.Garrison["Syr_lSAM_Jirah_1"] = 1
    CAP.setFlag("Syr_lSAM_Jirah_1" .. "_type", 6)
    CAP.aliveGroundGroups.Garrison["Turk_lSAM_Sanliurfa_1"] = 1
    CAP.setFlag("Turk_lSAM_Sanliurfa_1" .. "_type", 6)
    CAP.aliveGroundGroups.Garrison["Syr_lSAM_Tabqa_1"] = 1
    CAP.setFlag("Syr_lSAM_Tabqa_1" .. "_type", 6)
    CAP.aliveGroundGroups.Garrison["Syr_lSAM_Tiyas_1"] = 1
    CAP.setFlag("Syr_lSAM_Tiyas_1" .. "_type", 6)
    CAP.aliveGroundGroups.Garrison["Syr_lSAM_Hama_1"] = 1
    CAP.setFlag("Syr_lSAM_Hama_1" .. "_type", 6)

    CAP.DetectedTargets.Blue["Syr_lSAM_Duhur_1"] = 1
    CAP.DetectedTargets.Blue["Syr_lSAM_Kuweires_1"] = 1
    CAP.DetectedTargets.Blue["Syr_EWR_DU06"] = 1
    CAP.DetectedTargets.Blue["Syr_lSAM_Jirah_1"] = 1
    CAP.DetectedTargets.Blue["Syr_lSAM_Tabqa_1"] = 1
    CAP.DetectedTargets.Blue["Syr_lSAM_Tiyas_1"] = 1
    CAP.DetectedTargets.Blue["Syr_lSAM_Hama_1"] = 1

    CAP.log("initGround complete.")
end
mist.scheduleFunction(CAP.initGround, {}, timer.getTime() + 5)