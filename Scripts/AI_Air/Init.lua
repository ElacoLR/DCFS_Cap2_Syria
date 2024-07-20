-- Initialization.
-- 1. Spawn AWACS for Turkey. (Syria has no AWACS.)
-- 2. 

CAP.aliveAirGroups = {} -- Key : Group name / Value : Package number (AWACS value is always 1)

function CAP.initAir()
    trigger.action.activateGroup(Group.getByName("Template_Turkey_AWACS_Incirlik"))
    CAP.aliveAirGroups["Template_Turkey_AWACS_Incirlik"] = 1
end
mist.scheduleFunction(CAP.initAir, {}, timer.getTime() + 10)