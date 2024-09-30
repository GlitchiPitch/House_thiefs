--[[
    Было бы хорошо иметь все ассеты в одном месте, надо будет прикрутить этот модуль ко всем и убрать
    подгрузку ассетов внутри скриптов

]]

local replicatedStorage = game.ReplicatedStorage.Shared
local InsertService = game:GetService("InsertService")
local serverScriptService = game.ServerScriptService.Server
local types = require(replicatedStorage.Types)
local serverConfig = require(serverScriptService.Config)

function loadAsset(assetId: number)
    local success, model = pcall(InsertService.LoadAsset, InsertService, assetId)
    if success and model then
        model = model:GetChildren()[1]
        print(`{model.Name} loaded successfully `)
        return model
    else
        print(`assetId: {assetId} failed to load!`)
    end
end

local assets = {
    stealedBlockTemplate    = loadAsset(serverConfig.assetsList.stealedTool)    :: types.StealedBlock,
    houseTemplate           = loadAsset(serverConfig.assetsList.house)          :: types.House,
    teamTemplate            = loadAsset(serverConfig.assetsList.team)           :: types.TeamType,
    startMenu               = loadAsset(serverConfig.uiAssetsList.startMenu_2)  :: types.StartMenu,
    baseMap                 = loadAsset(serverConfig.assetsList.baseMap)        :: types.BaseMap,
}

type assetsList =
    'stealedBlockTemplate' |
    'houseTemplate' |
    'teamTemplate' |
    'startMenu' |
    'baseMap'

function getAsset(assetName: assetsList)
    if assets[assetName] then
        return assets[assetName]
    else
        error(`{assetName} is not found`)
    end
end

return
