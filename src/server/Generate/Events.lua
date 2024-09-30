--[[
    Генерит инвоки с серверными биндами по конфигу и отправляет их куда надо
]]

print("Events.lua")

local serverScriptService = game.ServerScriptService.Server
local replicatedStorage = game.ReplicatedStorage
local serverStorage = game.ServerStorage

local config = require(replicatedStorage.Shared.Config)
local serverConfig = require(serverScriptService.Config)

local invokeFolder = Instance.new("Folder")
local serverBindFolder = Instance.new("Folder")

function createInvokes()
    invokeFolder.Parent = replicatedStorage
    invokeFolder.Name = "Invokes"
    for i, invokeName in config.invokes do
        local invoke = Instance.new("RemoteFunction")
        invoke.Parent = invokeFolder
        invoke.Name = invokeName
    end
end

function createServerBind()
    serverBindFolder.Parent = serverStorage
    serverBindFolder.Name = "Bind"
    for i, bindName in serverConfig.serverBinds do
        local invoke = Instance.new("BindableEvent")
        invoke.Parent = serverBindFolder
        invoke.Name = bindName
    end
end



function init()
    createInvokes()
    createServerBind()
end

return {
    init = init,
}