local replicatedStorage = game.ReplicatedStorage
local folder = replicatedStorage:WaitForChild("Invokes")

function getInvoke(
    invoke: string
) : RemoteFunction
    return folder:FindFirstChild(invoke)
end

return getInvoke