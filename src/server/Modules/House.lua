--[[
    Чекает касание к блоку который удаляет из инвентаря сворованные блоки и если дом соперника все,
    то отправляет сигнал на ServerScriptService -> Server (line 79)

]]

local serverScriptService = game.ServerScriptService.Server
local replicatedStorage = game.ReplicatedStorage.Shared
local players = game.Players
local types = require(replicatedStorage.Types)
local getBind = require(serverScriptService.GetBind)
local serverConfig = require(serverScriptService.Config)

local endGameBind: BindableEvent = getBind(serverConfig.serverBinds.endGame)

function checkBackpack(player: Player)
    local house: types.House
    for i, tool in player.Backpack:GetChildren() do
        local houseValue = tool:FindFirstChild("House") :: ObjectValue?
        if houseValue then
            house = houseValue.Value.Parent :: types.House
            tool:Destroy()
        end
    end

    local equipedTool = player.Character:FindFirstChildOfClass("Tool")
    if equipedTool  then
        local houseValue = equipedTool:FindFirstChild("House")
        if houseValue then
            house = houseValue.Value.Parent :: types.House
            equipedTool:Destroy()
        end
    end

    if house and house.BlocksCount.Value == 0 then
        endGameBind:Fire(house)
    end

end

function init(houses: Folder & {types.House})
    for i, house in houses:GetChildren() do
        house.StealPoint.Touched:Connect(function(hit: BasePart)
            local player = players:GetPlayerFromCharacter(hit.Parent)
            if player then
                local playerTeam = player.Team :: types.TeamType
                if (playerTeam.House.Value == house) then
                    checkBackpack(player)
                end
            end
        end)
    end
end

return {
    init = init,
}