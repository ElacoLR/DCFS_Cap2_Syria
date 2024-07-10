CAP.Template = {}

CAP.Template.Air = {}
CAP.Template.Ground = {}

CAP.Template.Air.Turkey = {}
CAP.Template.Air.Syria = {}

-- Armored Template Index number decide the type.
-- 1 : Armored, 2 : Mechanized, 3 : Motorized, 4 : Short AA, 5 : Infantry
CAP.Template.Ground.Turkey = {"Template_Turkey_Armored", "Template_Turkey_Mechanized", "Template_Turkey_Motorized", "Template_Turkey_sAA", "Template_Turkey_Infantry"}
CAP.Template.Ground.Syria = {"Template_Syria_Armored", "Template_Syria_Mechanized", "Template_Syria_Motorized", "Template_Syria_sAA", "Template_Syria_Infantry"}

CAP.Zones = {}

CAP.Zones.Airport = {"Airport_Minakh", "Airport_Hatay", "Airport_Gaziantep", "Airport_Sanliurfa", "Airport_Aleppo"}
CAP.Zones.Airbase = {"Airbase_Incirlik", "Airbase_Kuweires"}

CAP.Zones.MilitaryBase = {"MilitaryBase_BA53", "MilitaryBase_BA89", "MilitaryBase_DA88"}

CAP.Zones.Factory = {"Factory_CB50", "Factory_CA04"}

CAP.Zones.Outpost = {"Outpost_DB21"}

-- Airport : Mechanized, mAA
-- Airbase : Armored, Mechanized, lAA
-- MilitaryBase : Armored, Mechanized, mAA
-- Factory : Motorized, sAA
-- Outpost : Infantry