CAP.DetectedTargets = {}

CAP.DetectedTargets.Blue = {}
CAP.DetectedTargets.Red = {}

function CAP.getDetectedEnemies()
    for groupName, _ in pairs(CAP.aliveAirGroups) do
        local iGroup = CAP.getAliveGroup(groupName)
        CAP.log("line 9")
        if iGroup ~= nil then
            local iGroupCon = iGroup:getController()

            local iDetTargets = iGroupCon:getDetectedTargets()
            CAP.log("line 14")
            for index, DetectedTarget in pairs(iDetTargets) do
                CAP.log("line 16")
                if DetectedTarget ~= nil then
                    CAP.log("line 18")
                    if DetectedTarget.object ~= nil then
                        CAP.log("line 20")
                        if CAP.getAliveUnit(DetectedTarget.object:getName()) ~= nil then
                            CAP.log("line 22")
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