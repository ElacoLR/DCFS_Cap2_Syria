local eH_Takeoff = {}

function CAP.executePackage(country) -- Only execute if no player assigned. If assigned player exist -> execute when the player choose the package.
    for id, data in pairs(CAP.Package.Air[country]) do
        if type(id) == 'number' then
            if #data.assignedPlayers == 0 then -- Check for any players.
                local copiedData = mist.utils.deepCopy(data)
                
                if data.missionType == 'BARCAP' then
                    local aiGroupName = CAP.createAirCAP(data.country, data.orbitPoints)
                    copiedData["assignedGroupNames"][#copiedData["assignedGroupNames"] + 1] = aiGroupName
                end

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

function eH_Takeoff:onEvent(e)
    if e.id == 18 then
        if Object.getCategory(e.initiator) == 1 and not Unit.getPlayerName(e.initiator) then
            local groupName = e.initiator:getGroup():getName()

            if CAP.missionList[groupName] then
                local groupCon = e.initiator:getGroup():getController()

                local dummyReset = groupCon:hasTask()
                groupCon:resetTask()

                mist.scheduleFunction(Controller.pushTask, {groupCon, CAP.missionList[groupName]}, timer.getTime() + 2)
                CAP.missionList[groupName] = nil
            end
        end
    end
end
world.addEventHandler(eH_Takeoff)