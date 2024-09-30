--[[
    Programmaly generating teams was made for scaling. if we will need more teams like on tycoons 6 or more
    we need just only add new team in the list

    of course ui will be not well after that.

]]

print("Teams.lua")

local vse_norm_so_scriptom = true

local replicatedStorage = game.ReplicatedStorage
local serverScriptService = game.ServerScriptService
local teams = game:GetService("Teams")

local types = require(replicatedStorage.Shared.Types)
local serverConfig = require(serverScriptService.Server.Config)
local loadAsset = require(replicatedStorage.Shared.LoadAsset)

local teamTemplate = loadAsset(serverConfig.assetsList.team)

if not teamTemplate then
    warn("teamTemplate is not loaded")
    vse_norm_so_scriptom = false
end

function init()
    -- генерит команды
    if not vse_norm_so_scriptom then return end

    for name, data in serverConfig.teamList do
        local team = teamTemplate:Clone()
        team.Parent = teams
        team.Name = name
        team.TeamColor = data.color
        team.MaxPlayers.Value = serverConfig.constant.MAX_PLAYERS
    end
end

function updateTeams()
    -- проверяет под какую команду не хватило место на карте и удаляет их

    if not vse_norm_so_scriptom then return end

    for i, team: types.TeamType in teams:GetTeams() do
        if team.House.Value == nil then
            team:Destroy()
        end
    end
end

return {
    init = init,
    updateTeams = updateTeams,
}