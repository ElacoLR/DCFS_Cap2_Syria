-- Repeat spawn function : by economy value of each countries.
-- CAP.Economy.Turkey etc. : Multiply by some number.
-- Spawn the reinforcement group at militarybase (random)

function CAP.groundReinforce(country)
    local militaryBases = {}

    for k, v in pairs(CAP.Zones.MilitaryBase) do
        if country == 'Turkey' and v == 3 then
            table.insert(militaryBases, k)
        elseif country == 'Syria' and v == 47 then
            table.insert(militaryBases, k)
        end
    end

    local spawnZone = militaryBases[math.random(1, #militaryBases)]
    CAP.spawnGround('Assault', country, spawnZone, false)

    CAP.doReinforce()
end

function CAP.doReinforce()
    local turkEco = CAP.Economy.Turkey
    local syrEco = CAP.Economy.Syria

    turkEco = math.floor(15000 / turkEco + 0.5)
    syrEco = math.floor(15000 / syrEco + 0.5)

    mist.scheduleFunction(CAP.groundReinforce, {'Turkey'}, timer.getTime() + turkEco)
    mist.scheduleFunction(CAP.groundReinforce, {'Syria'}, timer.getTime() + syrEco)
end
mist.scheduleFunction(CAP.doReinforce, {}, timer.getTime() + 10)