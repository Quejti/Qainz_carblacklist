function IsVehicleBlacklisted(vehicleModel)
    for _, blacklistedModel in ipairs(Config.BlacklistedVehicles) do
        if vehicleModel == GetHashKey(blacklistedModel) then
            return true
        end
    end
    return false
end

function DeleteBlacklistedVehicle(vehicle)
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)

        TriggerEvent('chat:addMessage', {
            args = {"[Qainz-blacklistcar]", Config.NotificationMessage}
        })
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if vehicle ~= 0 then
            local vehicleModel = GetEntityModel(vehicle)
            if IsVehicleBlacklisted(vehicleModel) then
                DeleteBlacklistedVehicle(vehicle)
            end
        end
    end
end)
