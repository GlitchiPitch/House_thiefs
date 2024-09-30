local serverStorage = game.ServerStorage
local folder = serverStorage:WaitForChild("Bind")

function getBind(
    bind: string
) : RemoteFunction
    return folder:FindFirstChild(bind)
end

return getBind