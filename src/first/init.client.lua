--[[

    

]]


print("init starting menu replicated first")

local vse_norm_so_scriptom = true

local replicatedFirst = game.ReplicatedFirst
local replicatedStorage = game.ReplicatedStorage:WaitForChild("Shared")
local teams = game:GetService("Teams")
local players = game.Players

local types = require(replicatedStorage.Types)
local getInvoke = require(replicatedStorage.GetInvoke)
local config = require(replicatedStorage.Config)

local player = players.LocalPlayer

local gui: types.StartMenu = replicatedStorage:WaitForChild("StartMenu")
local startMenuInvoke: RemoteFunction = getInvoke(config.invokes.startMenu)

if not gui or not startMenuInvoke then
    warn("gui is not loaded or startMenuInvoke is not loaded")
    vse_norm_so_scriptom = false
end

function onButtonActivated(button: types.TeamButton)
    local response = startMenuInvoke:InvokeServer(button.Team.Value)
    if response.status == true then
        gui.Enabled = false
    elseif response.status == false then
        button.Active = false
        local team = button.Team.Value :: types.TeamType
        button.TeamAmount.Text = response.message[1]
        task.wait(1)
        button.TeamAmount.Text = #team:GetPlayers() .. " | " .. team.MaxPlayers.Value
        button.Active = true
    end
end

function setupButtons()
    for i, team in teams:GetTeams() do
        local button = gui.TeamButtons.TeamButtonTemplate:Clone()
        button.Parent = gui.TeamButtons
        button.BackgroundColor3 = team.TeamColor.Color
        button.Name = team.Name
        button.Text = team.Name
        button.Team.Value = team
        button.TeamAmount.Text = #team:GetPlayers() .. " | " .. team.MaxPlayers.Value
        button.Visible = true
        button.Activated:Connect(function()
            onButtonActivated(button)
        end)
    end
    gui.TeamButtons.TeamButtonTemplate:Destroy()
end

function init()

    if not vse_norm_so_scriptom then return end

    replicatedFirst:RemoveDefaultLoadingScreen()
    gui.Parent = player.PlayerGui
    setupButtons()
    repeat task.wait() until game:IsLoaded()
end

init()