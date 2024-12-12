CAP.StopEngageThenMove = {}
CAP.StopEngageThenMove.detected = {}

for groupName, _ in pairs(CAP.aliveGroundGroups.Assault) do
    local gCon = Group.getByName(groupName):getController()

    local taskHold = {
        id = 'Hold',
        params = {
        }
    }

    local function detect()
        local targets = gCon:getDetectedTargets()

        for i = #targets, 1, -1 do
            if targets[i]:hasAttribute("Ground Units") then
            else
                table.remove(targets, i)
            end
        end

        if #targets > 0 then
            gCon:pushTask(taskHold)
            CAP.StopEngageThenMove.detected[groupName] = 1
        else
            CAP.StopEngageThenMove.detected[groupName] = nil
        end
    end
    mist.scheduleFunction(detect, {}, timer.getTime() + 1, 5)

    local function pop()
        gCon:popTask()
    end

    local function check()
        if detected[CAP.StopEngageThenMove.detected[i]] == nil then
            pop()
        end
    end
    mist.scheduleFunction(check, {}, timer.getTime() + 1, 20)
end