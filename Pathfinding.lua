local PathfindingService = game:GetService("PathfindingService")
local lplr = game:GetService("Players").LocalPlayer

local FindPath = function(endPosition)
    if not endPosition or not typeof(endPosition) == "CFrame" then
        error("Invalid endPosition")
        return false, {}, nil
    end
    
    if not lplr.Character or not lplr.Character.HumanoidRootPart then
        error("LocalPlayer character or HumanoidRootPart not found")
        return false, {}, nil
    end
    
    local path = PathfindingService:CreatePath()
    
    local success, message = pcall(function()
        path:ComputeAsync(lplr.Character.HumanoidRootPart.Position, endPosition.Position)
    end)
    
    if not success then
        error("Error computing path: " .. tostring(message))
        return false, {}, nil
    end
    
    local waypoints = {}
    local pathStatus = path.Status
    
    if pathStatus == Enum.PathStatus.Success then
        waypoints = path:GetWaypoints()
    end
    
    return pathStatus == Enum.PathStatus.Success, waypoints, path
end

local ShowPath = function(endPosition)
    local success, waypoints, path = FindPath(endPosition)
    
    if success then
        for _, child in ipairs(workspace:GetChildren()) do
            if child:IsA("Model") and child.Name == "Path" then
                child:Destroy()
            end
        end
        
        if #waypoints > 0 then
            local parent = Instance.new("Model")
            parent.Name = "Path"
            parent.Parent = workspace
            
            for i, waypoint in ipairs(waypoints) do
                local part = Instance.new("Part")
                part.Name = "PathPart"
                part.Size = Vector3.new(1, 1, 1)
                part.Position = waypoint.Position
                part.Anchored = true
                part.CanCollide = false
                
                part.Parent = parent
            end
        else
            print("No waypoints found in the path")
        end
    else
        print("Failed to find a valid path")
    end
end

local RemovePath = function()
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("Model") and child.Name == "Path" then
            child:Destroy()
        end
    end
end

local isMoving = false

local MoveCharacter = function(endPosition)
    if isMoving then
        print("Already moving, please wait for the current path to finish")
        return
    end
    
    isMoving = true
    
    local success, waypoints, path = FindPath(endPosition)
    
    if success then
        if #waypoints > 0 then
            for i, waypoint in ipairs(waypoints) do
                lplr.Character.Humanoid:MoveTo(waypoint.Position)
            end
        else
            isMoving = false
            print("No waypoints found in the path")
        end
    else
        isMoving = false
        print("Failed to find a valid path")
    end
    
    if success then
        while not isMoving do
            RemovePath()
        end
    end
end

return {
    FindPath = FindPath,
    ShowPath = ShowPath,
    RemovePath = RemovePath,
    MoveCharacter = MoveCharacter
}