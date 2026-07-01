local addon = RaidFarmTracker

function addon:SearchItem(query)

    query = string.lower(query or "")
    local results = {}

    for _, expansion in pairs(self.DB.data) do
        for _, raid in ipairs(expansion.raids) do
            for _, boss in ipairs(raid.bosses) do
                for _, item in ipairs(boss.loot) do

                    if string.find(string.lower(item.name), query) then
                        table.insert(results, {
                            raid = raid.name,
                            boss = boss.name,
                            item = item
                        })
                    end

                end
            end
        end
    end

    return results
end