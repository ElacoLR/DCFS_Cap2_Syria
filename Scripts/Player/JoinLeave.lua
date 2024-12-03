local eH_playerEnterUnit = {}
local eH_playerLeaveUnit = {}

function eH_playerEnterUnit:onEvent(e)
    if e.id == 20 then
        local unit = e.initiator

        if unit ~= nil then
            CAP.Players[unit:getPlayerName()] = unit

            CAP.createPlayerRadio(unit:getGroup():getID(), unit:getGroup())
        else
            CAP.log("playerEnterUnit failed.")
        end
    end
end
world.addEventHandler(eH_playerEnterUnit)

function eH_playerLeaveUnit:onEvent(e)
    if e.id == 5 or e.id == 6 or e.id == 8 or e.id == 9 or e.id == 21 or e.id == 30 then
        local unit = e.initiator

        if unit ~= nil then
            if unit:getPlayerName() ~= nil then
                CAP.Players[unit:getPlayerName()] = nil

                CAP.removePlayerRadio(unit:getGroup():getID())
            end
        end
    end
end
world.addEventHandler(eH_playerLeaveUnit)