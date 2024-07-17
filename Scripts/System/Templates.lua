CAP.Template = {}

CAP.Template.Air = {}

CAP.Template.Air.Turkey = {}
CAP.Template.Air.Syria = {}

CAP.Template.Ground = {}

-- Ground template : Index number decide the type.
-- 1 : Armored, 2 : Mechanized, 3 : Motorized, 4 : Short AA, 5 : Infantry

CAP.Template.Ground.Turkey = {"Template_Turkey_Armored", "Template_Turkey_Mechanized", "Template_Turkey_Motorized", "Template_Turkey_sAA", "Template_Turkey_Infantry"}
CAP.Template.Ground.Syria = {"Template_Syria_Armored", "Template_Syria_Mechanized", "Template_Syria_Motorized", "Template_Syria_sAA", "Template_Syria_Infantry"}

CAP.Template.Ground.Assault = {}

CAP.Template.Ground.Assault.Turkey = {"Template_Turkey_Assault"}
CAP.Template.Ground.Assault.Syria = {"Template_Syria_Assault"}

CAP.Zones = {}

-- Ground zones : Value number decide which country occupies the zone.
-- 1 : Turkey, 2 : Syria, 3 : ...

CAP.Zones.Airport = {["Airport_Minakh"] = 2, ["Airport_Hatay"] = 1, ["Airport_Gaziantep"] = 1, ["Airport_Sanliurfa"] = 1, ["Airport_Aleppo"] = 2, ["Airport_Taftanaz"] = 2}

CAP.Zones.Airbase = {["Airbase_Incirlik"] = 1, ["Airbase_Kuweires"] = 2, ["Airbase_Duhur"] = 2}

CAP.Zones.MilitaryBase = {["MilitaryBase_BA53"] = 1, ["MilitaryBase_BA89"] = 1, ["MilitaryBase_DA88"] = 1, ["MilitaryBase_CA20"] = 2, ["MilitaryBase_CA63"] = 2}

CAP.Zones.Factory = {["Factory_CB50"] = 1, ["Factory_YF60"] = 1, ["Factory_CB51"] = 1, ["Factory_CA04"] = 2, ["Factory_DA64"] = 2, ["Factory_CA30"] = 2, ["Factory_CA40"] = 2, 
    ["Factory_BA56"] = 1}

CAP.Zones.Outpost = {["Outpost_DB21"] = 1, ["Outpost_BA81"] = 1, ["Outpost_BA97"] = 2, ["Outpost_BV47"] = 1, ["Outpost_YE68"] = 1, ["Outpost_DA04"] = 2}

-- Airport : Mechanized, mAA
-- Airbase : Armored, Mechanized, lAA
-- MilitaryBase : Armored, Mechanized, mAA
-- Factory : Motorized, sAA
-- Outpost : Infantry

CAP.Buildings = {}

CAP.Buildings.Factory = {["Factory_CA04_1"] = 2, ["Factory_CA04_2"] = 2, ["Factory_CA04_3"] = 2, ["Factory_CA04_4"] = 2, ["Factory_CA30_1"] = 2, ["Factory_CA30_2"] = 2, 
    ["Factory_CA30_3"] = 2, ["Factory_CA40_1"] = 2, ["Factory_CA40_2"] = 2, ["Factory_CA40_3"] = 2, ["Factory_CA40_4"] = 2, ["Factory_CB50_1"] = 1, ["Factory_CB50_2"] = 1, 
    ["Factory_CB50_3"] = 1, ["Factory_CB50_4"] = 1, ["Factory_CB51_1"] = 1, ["Factory_CB51_2"] = 1, ["Factory_CB51_3"] = 1, ["Factory_CB51_4"] = 1, ["Factory_CB51_5"] = 1, 
    ["Factory_CB51_6"] = 1, ["Factory_YF60_1"] = 1, ["Factory_YF60_2"] = 1, ["Factory_YF60_3"] = 1, ["Factory_BA56_1"] = 1, ["Factory_BA56_2"] = 1, ["Factory_BA56_3"] = 1, 
    ["Factory_BA56_4"] = 1, ["Factory_BA56_5"] = 1, ["Factory_BA56_6"] = 1, ["Factory_BA56_7"] = 1}