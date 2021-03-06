
----------------------------------
--      Module Declaration      --
----------------------------------

local module, L = BigWigs:ModuleDeclaration("Gahz'ranka", "Zul'Gurub")


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Gahzranka",

	frostbreath_trigger = "Gahz\'ranka begins to perform Frost Breath\.",
	frostbreath_bar = "Frost Breath",
	massivegeyser_trigger = "Gahz\'ranka begins to cast Massive Geyser\.",
	massivegeyser_bar = "Massive Geyser",

	frostbreath_cmd = "frostbreath",
	frostbreath_name = "Frost Breath alert",
	frostbreath_desc = "Warn when the boss is casting Frost Breath.",

	massivegeyser_cmd = "massivegeyser",
	massivegeyser_name = "Massive Geyser alert",
	massivegeyser_desc = "Warn when the boss is casting Massive Geyser.",
} end )

L:RegisterTranslations("frFR", function() return {
	--cmd = "Gahzranka",

	frostbreath_trigger = "Gahz\'ranka commence à lancer Souffle de givre\.",
	frostbreath_bar = "Souffle de givre",
	massivegeyser_trigger = "Gahz\'ranka commence à lancer Geyser massif\.",
	massivegeyser_bar = "Geyser massif",

	--frostbreath_cmd = "frostbreath",
	frostbreath_name = "Alerte de Souffle de givre",
	frostbreath_desc = "Prévien quand le boss va lancer Souffle de givre.",

	--massivegeyser_cmd = "massivegeyser",
	massivegeyser_name = "Alerte de Geyser massif",
	massivegeyser_desc = "Prévien quand le boss va lancer Geyser massif.",
} end )

L:RegisterTranslations("esES", function() return {
	--cmd = "Gahzranka",

	frostbreath_trigger = "Gahz\'ranka comienza a lanzar Aliento de Escarcha\.",
	frostbreath_bar = "Aliento de Escarcha",
	massivegeyser_trigger = "Gahz\'ranka comienza a lanzar Géiser monumental\.",
	massivegeyser_bar = "Géiser monumental",

	--frostbreath_cmd = "frostbreath",
	frostbreath_name = "Alerta de Aliento de Escarcha",
	frostbreath_desc = "Avisa cuando el jefe lance Aliento de Escarcha.",

	--massivegeyser_cmd = "massivegeyser",
	massivegeyser_name = "Alerta de Géiser monumental",
	massivegeyser_desc = "Avisa cuando el jefe lance Géiser monumental.",
} end )

L:RegisterTranslations("deDE", function() return {
	--cmd = "Gahzranka",

	frostbreath_trigger = "Gahz\'ranka beginnt Frostatem auszuf\195\188hren\.",
	frostbreath_bar = "Frostatem",
	massivegeyser_trigger = "Gahz\'ranka beginnt Massiver Geysir zu wirken\.",
	massivegeyser_bar = "Massiver Geysir",

	--frostbreath_cmd = "frostbreath",
	frostbreath_name = "Alarm f\195\188r Frostatem",
	frostbreath_desc = "Warnen wenn Gahz'ranka beginnt Frostatem zu wirken.",

	--massivegeyser_cmd = "massivegeyser",
	massivegeyser_name = "Alarm f\195\188r Massiver Geysir",
	massivegeyser_desc = "Warnen wenn Gahz'ranka beginnt Massiver Geysir zu wirken.",
} end )


---------------------------------
--      	Variables 		   --
---------------------------------

-- module variables
module.revision = 20004 -- To be overridden by the module!
module.enabletrigger = module.translatedName -- string or table {boss, add1, add2}
module.toggleoptions = {"frostbreath", "massivegeyser", "bosskill"}

-- locals
local timer = {
	breath = 2,
	geyser = 1.5,
}
local icon = {
	breath = "Spell_Frost_FrostNova",
	geyser = "Spell_Frost_SummonWaterElemental",
}

------------------------------
--      Initialization      --
------------------------------

-- called after module is enabled
function module:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
end

------------------------------
--      Event Handlers	    --
------------------------------

function module:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE(msg)
	if msg == L["frostbreath_trigger"] and self.db.profile.frostbreath then
		self:Bar(L["frostbreath_bar"], timer.breath, icon.breath)
	elseif msg == L["massivegeyser_trigger"] and self.db.profile.massivegeyser then
		self:Bar(L["massivegeyser_bar"], timer.geyser, icon.geyser, true, "White")
	end
end
