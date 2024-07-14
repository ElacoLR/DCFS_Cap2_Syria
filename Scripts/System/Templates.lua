CAP.Template = {}

CAP.Template.Air = {}

CAP.Template.Air.Turkey = {}
CAP.Template.Air.Syria = {}

CAP.Template.Ground = {}

-- Ground template : Index number decide the type.
-- 1 : Armored, 2 : Mechanized, 3 : Motorized, 4 : Short AA, 5 : Infantry

CAP.Template.Ground.Turkey = {"Template_Turkey_Armored", "Template_Turkey_Mechanized", "Template_Turkey_Motorized", "Template_Turkey_sAA", "Template_Turkey_Infantry"}
CAP.Template.Ground.Syria = {"Template_Syria_Armored", "Template_Syria_Mechanized", "Template_Syria_Motorized", "Template_Syria_sAA", "Template_Syria_Infantry"}

CAP.Zones = {}

-- Ground zones : Value number decide which country occupies the zone.
-- 1 : Turkey, 2 : Syria, 3 : ...

CAP.Zones.Airport = {["Airport_Minakh"] = 2, ["Airport_Hatay"] = 1, ["Airport_Gaziantep"] = 1, ["Airport_Sanliurfa"] = 1, ["Airport_Aleppo"] = 2}

CAP.Zones.Airbase = {["Airbase_Incirlik"] = 1, ["Airbase_Kuweires"] = 2, ["Airbase_Duhur"] = 2}

CAP.Zones.MilitaryBase = {["MilitaryBase_BA53"] = 1, ["MilitaryBase_BA89"] = 1, ["MilitaryBase_DA88"] = 1, ["MilitaryBase_CA20"] = 2}

CAP.Zones.Factory = {["Factory_CB50"] = 1, ["Factory_CA04"] = 2}

CAP.Zones.Outpost = {["Outpost_DB21"] = 1}

-- Airport : Mechanized, mAA
-- Airbase : Armored, Mechanized, lAA
-- MilitaryBase : Armored, Mechanized, mAA
-- Factory : Motorized, sAA
-- Outpost : Infantry