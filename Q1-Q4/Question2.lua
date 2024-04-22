function printSmallGuildNames(memberCount)
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    -- Make sure query returns a valid result
    if resultId ~= false then
        repeat
            -- Print name value of each row
            local guildName = result.getString("name")
            print(guildName)
        until not result.next(resultId)
        result.free(resultId)
    end
end