
export type TeamType = Team & {
    MaxPlayers: IntValue,
    House: ObjectValue,
}

export type StealedBlock = Tool & {
    LastPosition: CFrameValue,
    House: ObjectValue,
    DefaultName: StringValue,
}

export type House = Model & {
    SpawnLocation: SpawnLocation,
    Body: Folder & {BasePart},
    BlocksCount: IntValue,
    StealPoint: Part,
}

export type BaseMap = Model & {
    HouseSpawnPoints: Folder & {Part},
    BuffsPoints: Folder & {Part}
}

export type TeamButton = TextButton & {
    Team: ObjectValue,
    TeamAmount: TextLabel
}

export type TeamButtons = Frame & {
    TeamButtonTemplate: TeamButton
}

export type StartMenu = ScreenGui & {
    TeamButtons: TeamButtons
}

export type MessageGui = ScreenGui & {
    MessageLabel: TextLabel
}

return true
