CAP.DetectedTargets = {}

CAP.DetectedTargets.Blue = {}
CAP.DetectedTargets.Red = {}

function CAP.getDetectedEnemies()
    for groupName, _ in pairs(CAP.aliveAirGroups) do
        local iGroupL = CAP.getAliveGroupLeader(groupName)

        if iGroupL ~= nil then
            local iGroupCon = iGroupL:getController()

            local iDetTargets = iGroupCon:getDetectedTargets()

            for _, DetectedTarget in pairs(iDetTargets) do
                if DetectedTarget ~= nil then
                    if DetectedTarget.object ~= nil then
                        if DetectedTarget.object:getCategory() == 1 and CAP.getAliveUnit(DetectedTarget.object:getName()) ~= nil then
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
end
mist.scheduleFunction(CAP.getDetectedEnemies, {}, timer.getTime() + 10, 300)