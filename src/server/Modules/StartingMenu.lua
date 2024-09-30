--[[
    Прнимает сигнал на (line 77) с ReplicatedFirst -> First 

    Здесь есть сетап для игрока, это костыль, сетапить нужно в другом месте,
    желательно сделать отдельный модуль

]]

print("StartingMenu.lua")

local replicatedStorage = game.ReplicatedStorage

local serverScriptService = game.ServerScriptService
local loadAsset = require(replicatedStorage.Shared.LoadAsset)
local types = require(replicatedStorage.Shared.Types)
local config = require(replicatedStorage.Shared.Config)
local serverConfig = require(serverScriptService.Server.Config)
local getInvoke = require(replicatedStorage.Shared.GetInvoke)

local startMenuInvoke: RemoteFunction = getInvoke(config.invokes.startMenu)
local startMenu = loadAsset(serverConfig.uiAssetsList.startMenu_2)

function checkBackpack(player: Player)
    for i, tool in player.Backpack:GetChildren() do
        local house = tool:FindFirstChild("House") :: ObjectValue
        local lastPosition = tool:FindFirstChild("LastPosition") :: CFrameValue
        local defaultName = tool:FindFirstChild("DefaultName") :: StringValue

        if house and lastPosition and defaultName then
            house = house.Value :: types.House
            local housePart = tool.Handle :: BasePart
            housePart.Anchored = true
            housePart.CanCollide = true
            housePart.Parent = house
            housePart.CFrame = lastPosition.Value
            housePart.Name = defaultName.Value
            house.Parent.BlocksCount.Value += 1

            tool:Destroy()
        end
    end
end

function setupPlayer(player: Player, team: types.TeamType)
    local house = team.House.Value :: types.House
    player.Team = team
    player:LoadCharacter()
    player.Character:MoveTo(house.SpawnLocation.Position)
    player.Character.Humanoid.Died:Connect(function()
        task.wait(3)
        checkBackpack(player)
        setupPlayer(player, team)
    end)
end

function checkTeam(team: types.TeamType)
    return #team:GetPlayers() < team.MaxPlayers.Value
end

function onStartingInvoke(player: Player, team: Team)

    print(`Hi {player}`, team)

    if checkTeam(team) then
        setupPlayer(player, team)
        return {
            status = true,
            message = {},
        }
    else
        return {
            status = false, 
            message = {"FULL TEAM"},
        }
    end
end

function init()
    startMenu.Parent = replicatedStorage.Shared
    startMenuInvoke.OnServerInvoke = onStartingInvoke
end

return {
    init = init
}
