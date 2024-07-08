--[[local num = 0
for k, v in pairs(CAP.Waypoints) do
    local vars = {}

    vars.pos = mist.utils.makeVec3(v)
    vars.markType = 5
    vars.text = tostring(num)
    vars.markForCoa = 2
    vars.fontSize = 10

    mist.marker.add(vars)

    num = num + 1
end]]

local path, cost = ShortestPath(CAP.WaypointsGraph, 152, 66)

if path then
    CAP.msgToAll("Shortest path from 152 to 66 : " .. table.concat(path, " -> "), 1)
    print("total cost : " .. cost)
else
    CAP.msgToAll(cost, 1) -- No path found
end

-- 가로 세로 38000 간격 잡기

-- 가로로 오른쪽으로 가면 y 값이 커짐

-- 세로로 아래쪽으로 가면 x 값이 작아짐

-- 302213.90625, -512213.90625

-- -371839.5625, 512770.0625