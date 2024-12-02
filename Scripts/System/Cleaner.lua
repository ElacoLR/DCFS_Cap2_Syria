function CAP.cleanWorld()
    local volS = {
        id = world.VolumeType.BOX,
        params = {
            min = mist.utils.makeVec3(CAP.getZone("world_sw")),
            max = mist.utils.makeVec3(CAP.getZone("world_ne")),
        }
    }

    world.removeJunk(volS)
end

local eH_removeEjectedPilots = {}

function eH_removeEjectedPilots:onEvent(e)
    if e.id == 31 then -- S_EVENT_LANDING_AFTER_EJECT
        if e.initiator then
            Object.destroy(e.initiator)
        end
    end
end

mist.scheduleFunction(CAP.cleanWorld, {}, timer.getTime() + 10, 600)

world.addEventHandler(eH_removeEjectedPilots)