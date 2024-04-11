local PathfindingService = game:GetService("PathfindingService")

local function ShowPath(waypoints)
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("Model") and child.Name == "Path" then
            child:Destroy()
        end
    end
    
    for i, waypoint in ipairs(waypoints) do
        local parent = Instance.new("Model")
        parent.Name = "Path"
        parent.Parent = workspace
        
        local part = Instance.new("Part")
        part.Name = "PathPart"
        part.Size = Vector3.new(1, 1, 1)
        part.Position = waypoint.Position
        part.Anchored = true
        part.CanCollide = false
        
        part.Parent = parent
    end
end

local function FindPath(endPosition)
    local lplr = game:GetService("Players").LocalPlayer
    if not endPosition or not typeof(endPosition) == "Vector3" then
        error("Invalid endPosition")
        return false, {}, nil
    end
    
    local lplr = game:GetService("Players").LocalPlayer
    if not lplr.Character or not lplr.Character.PrimaryPart then
        error("LocalPlayer character or PrimaryPart not found")
        return false, {}, nil
    end
    
    local path = PathfindingService:CreatePath({
        AgentRadius = lplr.Character.HumanoidRootPart.Size.X / 2,
        AgentHeight = lplr.Character.HumanoidRootPart.Size.Y,
        AgentCanJump = true,
        AgentJumpHeight = lplr.Character.Humanoid.JumpPower
    })
    
    local success, message = pcall(function()
        path:ComputeAsync(lplr.Character.PrimaryPart.Position, endPosition)
    end)
    
    if not success then
        error("Error computing path: " .. tostring(message))
        return false, {}, nil
    end
    
    local waypoints = {}
    local pathStatus = path.Status
    
    if pathStatus == Enum.PathStatus.Complete then
        waypoints = path:GetWaypoints()
        ShowPath(waypoints) 
    end
    
    return pathStatus == Enum.PathStatus.Complete, waypoints, path
end

local function MoveCharacter(endPosition)
    local lplr = game:GetService("Players").LocalPlayer
    if not lplr then
        error("LocalPlayer not found")
        return
    end
    
    local success, waypoints, path = FindPath(endPosition)
    
    if success then
        if #waypoints > 0 then
            for _, waypoint in ipairs(waypoints) do
                lplr.Character:MoveTo(waypoint.Position)
            end
        else
            print("No waypoints found in the path")
        end
    else
        print("Failed to find a valid path")
    end
end

return {
    FindPath = FindPath,
    ShowPath = ShowPath,
    MoveCharacter = MoveCharacter
}