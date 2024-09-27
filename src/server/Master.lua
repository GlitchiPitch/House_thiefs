local teams = game:GetService('Teams')
local players = game.Players
local replicatedFirst = game:GetService('ReplicatedFirst')

function setup()
    players.CharacterAutoLoads = false
end

function init()
    setup()
end

return {
    init = init,
}