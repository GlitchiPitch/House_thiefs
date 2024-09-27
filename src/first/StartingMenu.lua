local replicatedFirst = game.ReplicatedFirst
local players = game.Players

local player = players.LocalPlayer

local startingGui: ScreenGui & {
    TeamButtons: Frame & {
        BlueTeam: ImageButton,
        RedTeam: ImageButton,
    }
} = script:WaitForChild('StartingGui')

function setupGui()
    for i, button: ImageButton in startingGui.TeamButtons:GetChildren() do
        button.Activated:Connect(function()
            
        end)
    end
end

function init()
    replicatedFirst:RemoveDefaultLoadingScreen()
    startingGui.Parent = player.PlayerGui
    repeat task.wait() until game:IsLoaded()
    
end

return {
    init = init
}
