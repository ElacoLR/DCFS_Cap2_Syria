function Dijkstra(graph, startVertex)
    local distances = {}
    local previous = {}
    local unvisited = {}

    for vertex, _ in pairs(graph) do
        if vertex ~= "Type" then
            distances[vertex] = math.huge
            previous[vertex] = nil
            table.insert(unvisited, vertex)
        end
    end
    distances[startVertex] = 0

    while #unvisited > 0 do
        table.sort(unvisited, function(a, b) return distances[a] < distances[b] end)
        local current = table.remove(unvisited, 1)

        if distances[current] == math.huge then
            break
        end

        for neighbor, cost in pairs(graph[current]) do
            local alt = distances[current] + cost
            if alt < distances[neighbor] then
                distances[neighbor] = alt
                previous[neighbor] = current
            end
        end
    end

    return distances, previous
end

function ShortestPath(graph, startVertex, endVertex)
    local distances, previous = Dijkstra(graph, startVertex)
    local path = {}
    local current = endVertex

    while current do
        table.insert(path, 1, current)
        current = previous[current]
    end

    if path[1] == startVertex then
        return path, distances[endVertex]
    else
        return nil, "No path found"
    end
end

--[[
local path, cost = ShortestPath(myGraph, "A", "F")

if path then
    print("Shortest path from A to F : " .. table.concat(path, " -> "))
    print("total cost : " .. cost)
else
    print(cost) -> No path found
end
]]