-- такую инфу нельзя хранить в реплике
local teamList: {
    [string]: {
        color: BrickColor,
    }
} = {
    Chicken = {
        color = BrickColor.random()
    },
    Beavers = {
        color = BrickColor.random()
    }
}

local assetsList: {[string]: number} = {
    stealedTool = 93084121229239,
    house = 90020601139839,
    testHouse = 118564185964657,
    team = 90999921915225,
    baseMap = 116463669222445, -- 2 house points
}


local uiAssetsList: {[string]: number} = {
    startMenu_2 = 70827502809617, -- version for 2 teams
    startMenu_4 = 000, -- version for 2 teams
    startMenu_6 = 000, -- version for 2 teams
}

local serverBinds = {
    endGame = "EndGame"
}

local constant = {
    MAX_PLAYERS = 5,
    MAX_TOOLS = 2,
}

return {
    serverBinds = serverBinds,
    teamList = teamList,
    constant = constant,
    assetsList = assetsList,
    uiAssetsList = uiAssetsList,
}