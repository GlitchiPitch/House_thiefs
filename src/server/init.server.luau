--[[

    Это база, тут генерятся и настраиваются все элементы игры
    порядок запуска модулей внутри функции generate() важен, так как
    ReplicatedStorage -> GetInvoke и ServerScriptService -> GetBind ждут повления папок с ивентами
    отчего ServerScriptService -> Modules -> StartingMenu и ReplicatedFirst -> First не заработает пока не получит RemoteFunction

]]

--[[

    endGameBind (line 62) принимает сигнал с ServerScriptService -> Modules -> House (line 36)
    mapModule хранится отдельно чтобы можно было сделать reset, но это костыль

]]

print("init server")

local serverScriptService = game.ServerScriptService.Server
local replicatedStorage = game.ReplicatedStorage.Shared
local teams = game:GetService("Teams")
local players = game.Players

local generateModules = serverScriptService.Generate :: Folder
local modules = serverScriptService.Modules :: Folder

local types = require(replicatedStorage.Types)
local serverConfig = require(serverScriptService.Config)
local mapModule

local map: Folder & {
    Houses: Folder
} = Instance.new("Folder")

function setup()
    print("setup starting settings")
    players.CharacterAutoLoads = false
end

function generate()
    print("generate content")

    local teamsModule = require(generateModules.Teams)
    teamsModule.init()

    mapModule = require(generateModules.Map)
    mapModule.init(teams:GetTeams(), map)
    teamsModule.updateTeams()

    local eventsModule = require(generateModules.Events)
    eventsModule.init()

    -- меню требует инвоки и команды для генерации, поэтому модуль спавнится здесь
    local startMenu = require(modules.StartingMenu)
    startMenu.init()

    local stealingBlocks = require(modules.StealingBlocks)
    stealingBlocks.init()
end

function endGame(winnerHouse: types.House)
    print(`{winnerHouse} win`)
    map.Houses:ClearAllChildren()
    for i, team in teams:GetTeams() do
        mapModule.createHouse(team, i)
    end

    local houses = require(modules.House)
    houses.init(map.Houses)
end

function startGame()
    
    local getBind = require(serverScriptService.GetBind)
    local houses = require(modules.House)
    local endGameBind: BindableEvent = getBind(serverConfig.serverBinds.endGame)

    houses.init(map.Houses)

    endGameBind.Event:Connect(endGame)
end

function init()
    setup()
    generate()
    startGame()
end

init()
