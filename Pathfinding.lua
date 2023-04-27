local pathfinding = {}

function pathfinding:findPath(startPosition, endPosition)
    local path = game:GetService("PathfindingService"):CreatePath()
    path:ComputeAsync(startPosition, endPosition)

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


function pathfinding:followPath(player, waypoints, distanceThreshold)
    distanceThreshold = distanceThreshold or 1

    local currentWaypointIndex = 1
    local targetPosition = waypoints[currentWaypointIndex]

    local humanoid = player.Character.Humanoid
    humanoid:MoveTo(targetPosition)

    local connection
    connection = game:GetService("RunService").Heartbeat:Connect(function()
        local humanoidRootPart = player.Character.HumanoidRootPart
        local distanceToTarget = (targetPosition - humanoidRootPart.Position).Magnitude

        if distanceToTarget <= distanceThreshold then
            currentWaypointIndex = currentWaypointIndex + 1
            if currentWaypointIndex > #waypoints then
                connection:Disconnect()
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                return
            else
                targetPosition = waypoints[currentWaypointIndex]
                humanoid:MoveTo(targetPosition)
            end
        end

        humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, targetPosition)
    end)

    return function()
        connection:Disconnect()
    end
end

