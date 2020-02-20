Global("localization", nil)

Global("Locales", {
	["rus"] = { -- Russian, Win-1251
    ["Name"] = "материя",
	},
		
	["eng_eu"] = { -- English, Latin-1
    ["Name"] = "matter",
	}
})

localization = common.GetLocalization()
function GTL( strTextName )
	return Locales[ localization ][ strTextName ] or Locales[ "eng_eu" ][ strTextName ] or strTextName
end
