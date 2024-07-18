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
-- ENUM COUNTRY (To efficiently use scripting functions.)
-- 3 : Turkey, 47 : Syria, 3 : ...

CAP.Zones.Airport = {["Airport_Minakh"] = 47, ["Airport_Hatay"] = 3, ["Airport_Gaziantep"] = 3, ["Airport_Sanliurfa"] = 3, ["Airport_Aleppo"] = 47, ["Airport_Taftanaz"] = 47,}

CAP.Zones.Airbase = {["Airbase_Incirlik"] = 3, ["Airbase_Kuweires"] = 47, ["Airbase_Duhur"] = 47,}

CAP.Zones.MilitaryBase = {["MilitaryBase_BA53"] = 3, ["MilitaryBase_BA89"] = 3, ["MilitaryBase_DA88"] = 3, ["MilitaryBase_CA20"] = 47, ["MilitaryBase_CA63"] = 47, 
    ["MilitaryBase_DA40"] = 47,}

CAP.Zones.Factory = {["Factory_CB50"] = 3, ["Factory_YF60"] = 3, ["Factory_CB51"] = 3, ["Factory_CA04"] = 47, ["Factory_DA64"] = 47, ["Factory_CA30"] = 47, ["Factory_CA40"] = 47, 
    ["Factory_BA56"] = 3, ["Factory_DA91"] = 47,}

CAP.Zones.Outpost = {["Outpost_DB21"] = 3, ["Outpost_BA81"] = 3, ["Outpost_BA97"] = 47, ["Outpost_BV47"] = 3, ["Outpost_YE68"] = 3, ["Outpost_DA04"] = 47, ["Outpost_BV79"] = 47,}

-- Airport : Mechanized, mAA
-- Airbase : Armored, Mechanized, lAA
-- MilitaryBase : Armored, Mechanized, mAA
-- Factory : Motorized, sAA
-- Outpost : Infantry

CAP.Buildings = {}

CAP.Buildings.Factory = {["Factory_CA04_1"] = 47, ["Factory_CA04_2"] = 47, ["Factory_CA04_3"] = 47, ["Factory_CA04_4"] = 47, ["Factory_CA30_1"] = 47, ["Factory_CA30_2"] = 47, 
    ["Factory_CA30_3"] = 47, ["Factory_CA40_1"] = 47, ["Factory_CA40_2"] = 47, ["Factory_CA40_3"] = 47, ["Factory_CA40_4"] = 47, ["Factory_CB50_1"] = 3, ["Factory_CB50_2"] = 3, 
    ["Factory_CB50_3"] = 3, ["Factory_CB50_4"] = 3, ["Factory_CB51_1"] = 3, ["Factory_CB51_2"] = 3, ["Factory_CB51_3"] = 3, ["Factory_CB51_4"] = 3, ["Factory_CB51_5"] = 3, 
    ["Factory_CB51_6"] = 3, ["Factory_YF60_1"] = 3, ["Factory_YF60_2"] = 3, ["Factory_YF60_3"] = 3, ["Factory_BA56_1"] = 3, ["Factory_BA56_2"] = 3, ["Factory_BA56_3"] = 3, 
    ["Factory_BA56_4"] = 3, ["Factory_BA56_5"] = 3, ["Factory_BA56_6"] = 3, ["Factory_BA56_7"] = 3, ["Factory_DA91_1"] = 47, ["Factory_DA91_2"] = 47, ["Factory_DA91_3"] = 47, 
    ["Factory_DA64_1"] = 47, ["Factory_DA64_2"] = 47, ["Factory_DA64_3"] = 47, ["Factory_DA64_4"] = 47,}