function removeMemberFromPlayerParty(playerId, memberName)
    local player = Player(playerId)
    local party = player:getParty()
    local memberToRemove = Player(memberName)
    
    -- Iterate trough all party members
    for k,v in pairs(party:getMembers()) do
        if v == memberToRemove then
            party:removeMember(memberToRemove)
            -- Stop if we find member to remove
            break
        end
    end
end