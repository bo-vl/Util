local PathfindingService = game:GetService("PathfindingService")
local RunService = game:GetService("RunService")

local function getPath(startPos, endPos)
    local path = PathfindingService:CreatePath()
    path:ComputeAsync(startPos, endPos)
    return path:GetWaypoints()
end

local function moveAlongPath(path, humanoid)
    while #path > 0 do
        local waypoint = path[1]
        local distance = (waypoint.Position - humanoid.RootPart.Position).Magnitude
        if distance > 0.5 then
            humanoid:MoveTo(waypoint.Position)
            repeat
                RunService.Stepped:Wait()
            until #path == 0 or path[1] ~= waypoint
        else
            table.remove(path, 1)
        end
    end
end

-- local startPos = Vector3.new(0, 5, 0)
-- local endPos = Vector3.new(10, 5, 10)
-- local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
-- local path = getPath(startPos, endPos)
-- moveAlongPath(path, humanoid)
