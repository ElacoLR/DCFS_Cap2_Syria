-- Economy --
-- 1. Each countries economy decides the reinforcement multiplier.
-- 2. The economy value are based on the 'factory buildings' count for each country.
-- 3. CAP.Buildings.Factory : Iterate this table by k, v : k is building name, v is country value.
-- 4. Multiply the economy power by using v value.
-- 5. Repeat the check. See if building died.

CAP.Economy = {}

CAP.Economy.Turkey = 0
CAP.Economy.Syria = 0

mist.scheduleFunction(CAP.checkEconomy, {}, timer.getTime() + 1, 600) -- Repeat checking by 5 minutes.