function onLogout(player)
    -- There is no need for the releaseStorage function to be called with an addEvent call
    if player:getStorageValue(1000) == 1 then
        player:setStorageValue(1000, -1)
        return true
    end
    -- Return false in case it fails
    return false
end