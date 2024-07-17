-- Economy --
-- 1. Each countries economy decides the reinforcement multiplier.
-- 2. The economy value are based on the 'factory buildings' count for each country.
-- 3. CAP.Buildings.Factory : Iterate this table by k, v : k is building name, v is country value.
-- 4. Multiply the economy power by using v value.

CAP.Economy = {}

CAP.Economy.Turkey = 0
CAP.Economy.Syria = 0

function CAP.checkEconomy()
    CAP.Economy.Turkey = 0
    CAP.Economy.Syria = 0

    for k, v in pairs(CAP.Buildings.Factory) do
        if v == 1 then
            CAP.Economy.Turkey = CAP.Economy.Turkey + 1
        elseif v == 2 then
            CAP.Economy.Syria = CAP.Economy.Syria + 1
        end
    end
end
mist.scheduleFunction(CAP.checkEconomy, {}, timer.getTime() + 1, 300) -- Repeat checking by 5 minutes.