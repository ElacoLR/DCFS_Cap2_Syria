-- Init of set of waypoints to generate grid graph.
-- Use Dijkstra algr to generate routes for aircrafts.

CAP.Waypoints = {}

local distanceBetweenPoints = 38000 -- Adjust freely.

local firstPoint = mist.utils.makeVec2(CAP.getZone("WP_Gen_LT").point)
local endPoint = mist.utils.makeVec2(CAP.getZone("WP_Gen_RB").point)

local xPointer = firstPoint.x
local yPointer = firstPoint.y

local tableIdx = 1

CAP.Waypoints[tableIdx] = {["x"] = xPointer, ["y"] = yPointer} -- Starting point (left top), input Vec2

CAP.WaypointsGraph = Graph.new()

CAP.WaypointsGraph:AddVertex(tableIdx)

while (xPointer > endPoint.x) do
    while (yPointer < endPoint.y) do
        yPointer = yPointer + distanceBetweenPoints
        tableIdx = tableIdx + 1

        CAP.Waypoints[tableIdx] = {["x"] = xPointer, ["y"] = yPointer}
        CAP.WaypointsGraph:AddVertex(tableIdx)
    end
    
    xPointer = xPointer - distanceBetweenPoints
    yPointer = firstPoint.y
end

local function getWaypointIdx(x, y)
    for idx, point in pairs(CAP.Waypoints) do
        if point.x == x and point.y == y then
            return idx
        end
    end

    return nil
end

for idx, point in pairs(CAP.Waypoints) do
    local neighbors = {
        {x = point.x + distanceBetweenPoints, y = point.y}, -- Up
        {x = point.x - distanceBetweenPoints, y = point.y}, -- Down
        {x = point.x, y = point.y + distanceBetweenPoints}, -- Right
        {x = point.x, y = point.y - distanceBetweenPoints}, -- Left
        {x = point.x + distanceBetweenPoints, y = point.y + distanceBetweenPoints}, -- Top Right
        {x = point.x + distanceBetweenPoints, y = point.y - distanceBetweenPoints}, -- Top Left
        {x = point.x - distanceBetweenPoints, y = point.y + distanceBetweenPoints}, -- Bottom Right
        {x = point.x - distanceBetweenPoints, y = point.y - distanceBetweenPoints}, -- Bottom Left
    }

    for _, neighbor in ipairs(neighbors) do
        local neighborIdx = getWaypointIdx(neighbor.x, neighbor.y)

        if neighborIdx then
            CAP.WaypointsGraph:Connect(idx, neighborIdx, CAP.getDistance(point, neighbor))
        end
    end
end