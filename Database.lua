local addon = RaidFarmTracker

addon.DB = {}

addon.DB.data = {

    Wrath = {
        name = "Wrath of the Lich King",
        raids = {

            {
                name = "Icecrown Citadel",
                bosses = {
                    {
                        name = "The Lich King",
                        loot = {
                            {
                                itemID = 50818,
                                name = "Invincible's Reins",
                                type = "Mount",
                                dropChance = 0.8
                            }
                        }
                    }
                }
            }

        }
    }

}