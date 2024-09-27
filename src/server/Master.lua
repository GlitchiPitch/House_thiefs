local teams = game:GetService('Teams')
local players = game.Players
local replicatedFirst = game:GetService('ReplicatedFirst')


function createStartingGui()

    local tempButton: ImageButton = Instance.new("TextButton")
    local gui: ScreenGui = Instance.new('ScreenGui')
    gui.Name = 'TestGui'
    tempButton.Parent = gui
    

    gui.Parent = replicatedFirst:FindFirstChild('First'):FindFirstChild('StartingMenu')
end

function setup()
    players.CharacterAutoLoads = false    
    createStartingGui()
end

function init()
    setup()
end

return {
    init = init,
}