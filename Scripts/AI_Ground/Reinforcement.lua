-- Repeat spawn function : by economy value of each countries.
-- CAP.Economy.Turkey etc. : Multiply by some number.
-- Spawn the reinforcement group at militarybase (random)

function CAP.groundReinforce(country)
    local militaryBases = {}

    for k, v in pairs(CAP.Zones.MilitaryBase) do
        if country == 'Turkey' and v == 1 then
            table.insert(militaryBases, k)
        elseif country == 'Syria' and v == 2 then
            table.insert(militaryBases, k)
        end
    end

    local spawnZone = militaryBases[math.random(1, #militaryBases)]
    CAP.spawnGround('Assault', country, spawnZone, false)

    CAP.msgToAll("Reinforced country : " .. country, 5)

    CAP.doReinforce()
end

function CAP.doReinforce()

end