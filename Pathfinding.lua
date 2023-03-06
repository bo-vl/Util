local Lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Robobo2022/notify-lib/main/lib'),true))()
local Plrs = game:GetService("Players")
local lplr = Plrs.LocalPlayer
local Character = lplr.Character or lplr.CharacterAdded:Wait()
local Humanoid = lplr.Character:WaitForChild("Humanoid")
local HumanoidRootPart = lplr.Character:WaitForChild("HumanoidRootPart")
local PathFindingService = game:GetService("PathfindingService")
local TweenSerivce = game:GetService("TweenService")

local pathfinding = {}

local Settings = {
    [KeybindInput] = false
}

lplr.CharacterAdded:Connect(function()
    Humanoid = lplr.Character:WaitForChild("Humanoid")
    HumanoidRootPart = lplr.Character:WaitForChild("HumanoidRootPart")
end)

function pathfinding:MoveTo(Position, Wait)
    local Success, Error = pcall(function()
        local Begin

        if Humanoid.RigType == Enum.HumanoidRigType.R15 then
            Begin = Character.UpperTorso or Character.Torso;
        elseif Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
            Begin = HumanoidRootPart;
        end
    
        local Path = PathFindingService:FindPathAsync(Begin.Position, Position)
        local Waypoints = Path:GetWaypoints()
    
        if #Waypoints == 0 then
            Lib.prompt("Error", "No path found", 5)
            return
        end
    
        for Waypoint = 1, #Waypoints do
            if Waypoints[Waypoint].Action == Enum.PathWaypointAction.Jump then
                Humanoid.Jump = true
                Humanoid:MoveTo(Waypoints[Waypoint + 3].Position)
    
                if Wait then
                    Humanoid.MoveToFinished:Wait()
                end
            else
                Humanoid:MoveTo(Waypoints[Waypoint].Position)
    
                if Wait then
                    Humanoid.MoveToFinished:Wait()
                end
            end
        end
    end)

    if not Success then
        Lib.prompt("Error", "" .. Error, 5)
        return
    else
        Lib.prompt("Success", "Moved to position", 5)
    end
end

function pathfinding:TweenTo(Position, Wait)
    local Success, Error = pcall(function()
        local Begin

        if Humanoid.RigType == Enum.HumanoidRigType.R15 then
            Begin = Character.UpperTorso or Character.Torso;
        elseif Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
            Begin = HumanoidRootPart;
        end
    
        local Path = PathFindingService:FindPathAsync(Begin.Position, Position)
        local Waypoints = Path:GetWaypoints()
    
        if #Waypoints == 0 then
            Lib.prompt("Error", "No path found", 5)
            return
        end
    
        for Waypoint = 1, #Waypoints do
            local FarWayPoint
            if Waypoints[Waypoint + 3] then
                FarWayPoint = Waypoints[Waypoint + 3].Position
            else
                FarWayPoint = Waypoints[Waypoint].Position
            end
    
            local Distance = (FarWayPoint - Begin.Position).Magnitude
            local TweenInfo = TweenInfo.new(Distance / Humanoid.WalkSpeed, Enum.EasingStyle.Linear)
            local Tween = TweenSerivce:Create(HumanoidRootPart, TweenInfo, {CFrame = CFrame.new(FarWayPoint)})
            Tween:Play()
    
            if Wait then
                Tween.Completed:Wait()
            end
        end
    end)

    if not Success then
        Lib.prompt("Error", "" .. Error, 5)
    else
        Lib.prompt("Success", "Moved to position", 5)
    end
end

function pathfinding:TeleportTo(Position)
    local Success, Error = pcall(function()
        local Begin

        if Humanoid.RigType == Enum.HumanoidRigType.R15 then
            Begin = Character.UpperTorso or Character.Torso;
        elseif Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
            Begin = HumanoidRootPart;
        end
    
        local Path = PathFindingService:FindPathAsync(Begin.Position, Position)
        local Waypoints = Path:GetWaypoints()
    
        if #Waypoints == 0 then
            Lib.prompt("Error", "No path found", 5)
            return
        end
    
        HumanoidRootPart.CFrame = CFrame.new(Waypoints[#Waypoints].Position)
    end)

    if not Success then
        Lib.prompt("Error", "" .. Error, 5)
        return
    else
        Lib.prompt("Success", "Moved to position", 5)
    end
end

function pathfinding:Setting(Settings, Value)
    local Success, Error = pcall(function()
        Settings[Settings] = Value
    end)

    if not Success then
        Lib.prompt("Error", "" .. Error, 5)
        return
    else
        Lib.prompt("Success", "Set setting", 5)
    end

end

return pathfinding