local Util = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robobo2022/Util/main/Load.lua"))()
local pathfinding = {}

function pathfinding:findPath(endPosition)
    local path = game:GetService("PathfindingService"):CreatePath()
    path:ComputeAsync(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, endPosition)

    local waypoints = {}
    if path.Status == Enum.PathStatus.Success then
        for _, waypoint in ipairs(path:GetWaypoints()) do
            local part = Instance.new("Part")
            part.Size = Vector3.new(1, 1, 1)
            part.Position = waypoint.Position
            part.Anchored = true
            part.CanCollide = false
            part.Color = Color3.new(0, 1, 0)
            part.Parent = workspace
            table.insert(waypoints, waypoint.Position)
        end
    end
    return waypoints
end