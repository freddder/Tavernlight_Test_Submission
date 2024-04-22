void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    bool wasPlayerCreated = false;
    Player* player = g_game.getPlayerByName(recipient);
    if (!player) {
        player = new Player(nullptr); // Memory leak is being cause by heap memory allocation and not deleting it
        wasPlayerCreated = true; // Set flag to true for future deleting of player
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player;
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    // In case player was created, make sure to delete it once done
    if (wasPlayerCreated) {
        delete player;
    }
}