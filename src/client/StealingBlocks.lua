--[[
    этот скрипт чекает клик мышки и отправляет сигнал на ServerScriptService -> Modules -> StealingBlock (line 73)
]]

local replicatedStorage = game.ReplicatedStorage
local players = game.Players

local types = require(replicatedStorage.Shared.Types)
local config = require(replicatedStorage.Shared.Config)
local getInvoke = require(replicatedStorage.Shared.GetInvoke)

local clickInvoke: RemoteFunction = getInvoke(config.invokes.stealingBlocks)

local player = players.LocalPlayer
local mouse = player:GetMouse()

function showMessage(message: {string})
    print(message)
    task.wait(1)
    print(message)
end

function onClick()
    local mouseTarget = mouse.Target
    if mouseTarget:IsA("BasePart") then
        local response: {status: boolean, message: {string}} = clickInvoke:InvokeServer(mouseTarget)
        if response.status == true then
            showMessage(response.message)
        elseif response.status == false then
            showMessage(response.message)
        end
    end
end

function init()
    mouse.Button1Down:Connect(onClick)
end

return {
    init = init
}