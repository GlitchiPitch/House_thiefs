local InsertService = game:GetService("InsertService")
return function(assetId: number)
    local success, model = pcall(InsertService.LoadAsset, InsertService, assetId)
    if success and model then
        model = model:GetChildren()[1]
        print(`{model.Name} loaded successfully `)
        return model
    else
        print(`assetId: {assetId} failed to load!`)
    end
end