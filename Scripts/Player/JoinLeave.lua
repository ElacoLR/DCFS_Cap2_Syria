local eH_playerEnterUnit = {}

function eH_playerEnterUnit:onEvent(e)
    if e.id == 20 then
        local unit = e.initiator

        if unit ~= nil then
            CAP.removePlayerRadio(unit:getGroup():getID())

            CAP.Players[unit:getPlayerName()] = unit
            CAP.Players.Units[unit:getName()] = unit:getPlayerName()

            CAP.createPlayerRadio(unit:getGroup():getID(), unit:getGroup())
        else
            CAP.log("playerEnterUnit failed.")
        end
    end
end
world.addEventHandler(eH_playerEnterUnit)