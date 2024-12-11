local eH_engineStart = {}

function CAP.executePackage(country) -- Only execute if no player assigned. If assigned player exist -> execute when the player choose the package.
    for id, data in pairs(CAP.Package.Air[country]) do
        if type(id) == 'number' then
            if #data.assignedPlayers == 0 then -- Check for any players.
                local copiedData = mist.utils.deepCopy(data)
                local aiGroupName

                if data.missionType == 'BARCAP' then
                    aiGroupName = CAP.createAirCAP(data.country, data.orbitPoints)
                elseif data.missionType == 'SEAD' then
                    aiGroupName = CAP.createAirSEAD(data.country, data.targetGroupName)
                elseif data.missionType == 'DEAD' then
                    aiGroupName = CAP.createAirDEAD(data.country, data.targetGroupName)
                elseif data.missionType == 'Strike' then
                    aiGroupName = CAP.createAirStrike(data.country, data.targetGroupName)
                end

                copiedData["assignedGroupNames"][#copiedData["assignedGroupNames"] + 1] = aiGroupName

                CAP.Package.Air.Active[country][id] = copiedData
                CAP.Package.Air[country][id] = nil
            end
        end
    end
    CAP.doExecutePackage(country)
end

function CAP.doExecutePackage(country)
    if country == 'Turkey' then
        mist.scheduleFunction(CAP.executePackage, {'Turkey'}, timer.getTime() + math.random(60, 90))
    elseif country == 'Syria' then
        mist.scheduleFunction(CAP.executePackage, {'Syria'}, timer.getTime() + math.random(60, 90))
    end
end
mist.scheduleFunction(CAP.doExecutePackage, {'Turkey'}, timer.getTime() + 60)
mist.scheduleFunction(CAP.doExecutePackage, {'Syria'}, timer.getTime() + 60)

function eH_engineStart:onEvent(e)
    if e.id == 18 then -- S_EVENT_ENGINE_STARTUP
        if Object.getCategory(e.initiator) == 1 and not Unit.getPlayerName(e.initiator) then
            local groupName = e.initiator:getGroup():getName()

            if CAP.missionList[groupName] then
                local groupCon = e.initiator:getGroup():getController()

                local dummyReset = groupCon:hasTask()
                groupCon:resetTask()

                mist.scheduleFunction(Controller.setTask, {groupCon, CAP.missionList[groupName]}, timer.getTime() + 2)
                mist.scheduleFunction(Controller.setOption, {groupCon, AI.Option.Air.id.ROE, AI.Option.Air.val.ROE.OPEN_FIRE}, timer.getTime() + 4)

                CAP.missionList[groupName] = nil
            end
        end
    end
end
world.addEventHandler(eH_engineStart)