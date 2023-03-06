local Lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Robobo2022/notify-lib/main/lib'),true))()
local Plrs = game:GetService("Players")
local lplr = Plrs.LocalPlayer
local Humanoid = lplr.Character:WaitForChild("Humanoid")
local HumanoidRootPart = lplr.Character:WaitForChild("HumanoidRootPart")
local PathFindingService = game:GetService("PathfindingService")
local TweenSerivce = game:GetService("TweenService")

local pathfinding = {}

lplr.CharacterAdded:Connect(function()
    Humanoid = lplr.Character:WaitForChild("Humanoid")
    HumanoidRootPart = lplr.Character:WaitForChild("HumanoidRootPart")
end)

function pathfinding:MoveTo(Position, wait)
    local Begin

    local Path = PathFindingService:FindPathAsync(Begin.Position, Position)
    local Waypoints = Path:GetWaypoints()

    if #Waypoints == 0 then
        Lib.prompt("Error", "No path found", 5)
        return
    end

    for Waypoint = 1, #Waypoints do
        local FarWayPoint
        if Waypoints[Waypoint + 1] then
            FarWayPoint = Waypoints[Waypoint + 1].Position
        else
            FarWayPoint = Waypoints[Waypoint].Position
        end

        local Distance = (HumanoidRootPart.Position - Position).Magnitude
        local TweenInfo = TweenInfo.new(Distance / Humanoid.WalkSpeed, Enum.EasingStyle.Linear)
        local Tween = TweenSerivce:Create(HumanoidRootPart, TweenInfo, {CFrame.new(FarWayPoint + Vector3.new(0, 2, 0))})
        Tween:Play()

        if wait then
            Tween.Completed:Wait()
            lib.prompt("Success", "Moved to position", 5)
        end
    end
end

return pathfinding