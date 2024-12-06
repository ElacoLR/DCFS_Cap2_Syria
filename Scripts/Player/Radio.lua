function CAP.createPlayerRadio(gID, groupData)
    CAP.removePlayerRadio(gID)

    CAP.Players.Radio[gID] = mist.scheduleFunction(missionCommands.addSubMenuForGroup, {gID, "캠페인 메뉴", nil}, timer.getTime() + 1)

    local platoon = mist.scheduleFunction(missionCommands.addSubMenuForGroup, {gID, "편대원 초대", CAP.Players.Radio[gID]}, timer.getTime() + 2)
    mist.scheduleFunction(missionCommands.addCommandForGroup, {gID, "미션 할당", CAP.Players.Radio[gID], CAP.assignPlayerMission, groupData}, timer.getTime() + 2)

    for _, playerName in pairs(CAP.Players.Units) do
        mist.scheduleFunction(missionCommands.addCommandForGroup, {gID, playerName, platoon, CAP.invitePlayer, groupData, playerName}, timer.getTime() + 3)
    end
end

function CAP.removePlayerRadio(gID)
    missionCommands.removeItem(CAP.Players.Radio[gID])
end