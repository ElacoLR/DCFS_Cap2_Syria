CAP.DetectedTargets = {}

CAP.DetectedTargets.Blue = {}
CAP.DetectedTargets.Red = {}

-- Key : Group name / Value : Group type ( 1 : Armored, 2 : Mechanized, 3 : Motorized, 4 : Short AA, 5 : Medium AA, 6 : Long AA, 7 : Infantry )

-- Not working as I intended.
-- Pretend that blue coalition is getting satellite image occasionally to get whereabouts of mSAM and lSAM.
-- Other units are based on getDetectedTargets as usual.
-- Input mSAM and lSAM data to CAP.DetectedTargets.Blue in .\AI_Ground\Init.lua

function CAP.getDetectedEnemies()
    for groupName, _ in pairs(CAP.aliveAirGroups) do
        local iGroup = CAP.getAliveGroup(groupName)

        if iGroup ~= nil then
            local iGroupCon = iGroup:getController()

            local iDetTargets = iGroupCon:getDetectedTargets()
            for index, DetectedTarget in pairs(iDetTargets) do
                if DetectedTarget ~= nil then
                    if DetectedTarget.object ~= nil then
                        if CAP.getAliveUnit(DetectedTarget.object:getName()) ~= nil then
                            local detUnit = CAP.getAliveUnit(DetectedTarget.object:getName())
                            local detGroup = detUnit:getGroup()

                            local coal = detUnit:getCoalition()

                            if coal == 1 and CAP.DetectedTargets.Blue[detGroup:getName()] == nil then
                                CAP.DetectedTargets.Blue[detGroup:getName()] = 1
                            elseif coal == 2 and CAP.DetectedTargets.Red[detGroup:getName()] == nil then
                                CAP.DetectedTargets.Red[detGroup:getName()] = 1
                            end
                        end
                    end
                end
            end
        end
    end

    -- Refresh
    for coal, tbl in pairs(CAP.DetectedTargets) do
        for groupName, val in pairs(tbl) do
            if CAP.getAliveGroup(groupName) == nil then
                CAP.DetectedTargets[coal][groupName] = nil
            end
        end
    end
end
mist.scheduleFunction(CAP.getDetectedEnemies, {}, timer.getTime() + 5, 60)