
print("Map.lua")

local vse_norm_so_scriptom = true


local replicatedStorage = game.ReplicatedStorage.Shared
local serverScriptService = game.ServerScriptService.Server

local loadAsset = require(replicatedStorage.LoadAsset)
local types = require(replicatedStorage.Types)
local serverConfig = require(serverScriptService.Config)


local houses = Instance.new("Folder")
houses.Name = "Houses"

-- make anchor point for house above the bottom
local houseTemplate: types.House = loadAsset(serverConfig.assetsList.testHouse)
local baseMap: types.BaseMap = loadAsset(serverConfig.assetsList.baseMap)

if not houseTemplate or not baseMap then
    warn("houseTemplate is not loaded or baseMap is not loaded")
    vse_norm_so_scriptom = false
end

function createHouse(team: types.TeamType, index: number)
    
    local spawnPoints = baseMap.HouseSpawnPoints:GetChildren() :: {Part}
    if spawnPoints[index] then
        local house = houseTemplate:Clone() :: types.House
        house.Parent = houses
        house.Name = team.Name .. "'s" .. " " .. "House"
        house:PivotTo(spawnPoints[index].CFrame)
        house.BlocksCount.Value = #house.Body:GetDescendants()
        team.House.Value = house

    end
end

function init(teams: {types.TeamType}, map: Folder)

    --[[
        пробегается по командам, смотрит есть ли место под нее на карте и добавляет переменные, чтобы через команду
        удобно добраться до дома
    ]]

    if not vse_norm_so_scriptom then return end

    map.Parent = workspace
    baseMap.Parent = map
    houses.Parent = map
    for i, team in teams do
        createHouse(team, i)
    end
end

return {
    init = init,
    createHouse = createHouse,
}