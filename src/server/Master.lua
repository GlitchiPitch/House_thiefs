local teams = game:GetService('Teams')
local players = game.Players

local teamList: {[string]: {color: BrickColor}} = {
    red = {color = BrickColor.palette(12)},
    blue = {color = BrickColor.palette(13)}
}

function createTeams()
    for teamName, _team in teamList do
        local team = Instance.new('Team')
        team.Parent = teams
        team.TeamColor = _team.color
        team.Name = teamName
    end
end

function setup()
    players.CharacterAutoLoads = false    
    createTeams()
end

function init()
    setup()
end

return {
    init = init,
}