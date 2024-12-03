function CAP.createPlayerRadio(gID, groupData)
    CAP.Players.Radio[gID] = missionCommands.addSubMenuForGroup(gID, "캠페인 메뉴", nil)

    local platoon = missionCommands.addSubMenu("편대원 초대", CAP.Players.Radio[gID])
    missionCommands.addCommand("미션 할당", CAP.Players.Radio[gID], CAP.assignPlayerMission, groupData)

    for playerName, _ in pairs(CAP.Players) do
        missionCommands.addCommand(playerName, platoon, CAP.invitePlayer, groupData, playerName)
    end
end

function CAP.removePlayerRadio(gID)
    missionCommands.removeItem(CAP.Players.Radio[gID])
end