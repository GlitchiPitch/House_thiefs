--[[

    stealingEvent get signal from StarterPlayer -> PlayerScripts -> Client -> StealingBlock (line 28)
]]



local vse_norm_so_scriptom = true

local serverScriptService = game.ServerScriptService
local replicatedStorage = game.ReplicatedStorage

local types = require(replicatedStorage.Shared.Types)
local config = require(replicatedStorage.Shared.Config)
local serverConfig = require(serverScriptService.Server.Config)
local getInvoke = require(replicatedStorage.Shared.GetInvoke)
local loadAsset = require(replicatedStorage.Shared.LoadAsset)

local stealingEvent: RemoteFunction = getInvoke(config.invokes.stealingBlocks)
local stealedBlockTemplate: types.StealedBlock = loadAsset(serverConfig.assetsList.stealedTool)

if not stealingEvent or not stealedBlockTemplate then
    warn("stealingEvent is not loaded or stealedBlockTemplate is not loaded")
    vse_norm_so_scriptom = false
end

function createStealingBlock(handle: BasePart) : Tool
    local tool = stealedBlockTemplate:Clone()
    tool.DefaultName.Value = handle.Name
    handle.Name = "Handle"

    tool.House.Value = handle.Parent
    tool.LastPosition.Value = handle.CFrame

    handle.Parent = tool
    handle.Anchored = false
    handle.CanCollide = false
    handle:ClearAllChildren()

    return tool
end

function onClick(player: Player, target: BasePart)

    print(`{player} and {target}`)

    if not vse_norm_so_scriptom then return end

    local playerTeam = player.Team :: types.TeamType
    local clickedHouse = target:FindFirstAncestorOfClass("Model") :: types.House
    local isNotPlayerHouse = not (clickedHouse == playerTeam.House.Value)
    local enoughSpaceIntoBackpack = #player.Backpack:GetChildren() < serverConfig.constant.MAX_TOOLS
    local magnitude = (target.Position - player.Character:GetPivot().Position).Magnitude < 10
    if isNotPlayerHouse and enoughSpaceIntoBackpack and magnitude then
        clickedHouse.BlocksCount.Value -= 1
        local tool = createStealingBlock(target)
        tool.Parent = player.Backpack
        return {
            status = true,
            message = {"You stealed block"}
        }
    else
        return {
            status = false,
            message = {
                not isNotPlayerHouse and "This is your house" or nil,
                not enoughSpaceIntoBackpack and "Full Backpack" or nil,
            }
        }
    end
end

function init()
    stealingEvent.OnServerInvoke = onClick
end


return {
    init = init
}