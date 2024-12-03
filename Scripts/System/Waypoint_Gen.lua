-- Init of set of waypoints to generate grid graph.
-- Use Dijkstra algr to generate routes for aircrafts.

CAP.Waypoints = {}

CAP.distanceBetweenPoints = 38000 -- Adjust freely. / Default : 38000

local firstPoint = mist.utils.makeVec2(CAP.getZone("WP_Gen_LT").point)
local endPoint = mist.utils.makeVec2(CAP.getZone("WP_Gen_RB").point)

local xPointer = mist.utils.round(firstPoint.x)
local yPointer = mist.utils.round(firstPoint.y)

local tableIdx = 1

CAP.Waypoints[tableIdx] = {["x"] = xPointer, ["y"] = yPointer} -- Starting point (left top), input Vec2

CAP.WaypointsGraph = Graph.new()

CAP.WaypointsGraph:AddVertex(tableIdx)

while (xPointer > mist.utils.round(endPoint.x)) do
    while (yPointer < mist.utils.round(endPoint.y)) do
        yPointer = yPointer + CAP.distanceBetweenPoints
        tableIdx = tableIdx + 1

        CAP.Waypoints[tableIdx] = {["x"] = xPointer, ["y"] = yPointer}
        CAP.WaypointsGraph:AddVertex(tableIdx)
    end
    
    xPointer = xPointer - CAP.distanceBetweenPoints
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
        {x = point.x + CAP.distanceBetweenPoints, y = point.y}, -- Up
        {x = point.x - CAP.distanceBetweenPoints, y = point.y}, -- Down
        {x = point.x, y = point.y + CAP.distanceBetweenPoints}, -- Right
        {x = point.x, y = point.y - CAP.distanceBetweenPoints}, -- Left
        {x = point.x + CAP.distanceBetweenPoints, y = point.y + CAP.distanceBetweenPoints}, -- Top Right
        {x = point.x + CAP.distanceBetweenPoints, y = point.y - CAP.distanceBetweenPoints}, -- Top Left
        {x = point.x - CAP.distanceBetweenPoints, y = point.y + CAP.distanceBetweenPoints}, -- Bottom Right
        {x = point.x - CAP.distanceBetweenPoints, y = point.y - CAP.distanceBetweenPoints}, -- Bottom Left
    }

    for _, neighbor in ipairs(neighbors) do
        local neighborIdx = getWaypointIdx(neighbor.x, neighbor.y)

        if neighborIdx then
            CAP.WaypointsGraph:Connect(idx, neighborIdx, CAP.getDistance(point, neighbor))
        end
    end
end

function CAP.searchNearestVertex(coord)
    coord = mist.utils.makeVec2(coord)

    local coordX = coord.x
    local coordY = coord.y

    local nearestPoint = 1

    for i = 2, #CAP.Waypoints do
        if CAP.getDistance(coord, CAP.Waypoints[i]) < CAP.getDistance(coord, CAP.Waypoints[nearestPoint]) then
            nearestPoint = i
        end
    end

    return nearestPoint
end