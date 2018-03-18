local Plugin = {
	Version = "1.0",
	HasConfig = true,
	ConfigName = "AFKDetector.json",
	DefaultConfig = {
		KickTime    = 300,
		WarningTime = 150,
		SpecMult    = 0,
	},
	CheckConfig            = true,
	CheckConfigTypes       = true,
	CheckConfigRecursively = true,
	Conflicts = {
		DisableThem = {
			"afkkick"
		}
	},
}

function Plugin:SetupDataTable()
	self:AddDTVar("integer (0 to 1800)", "kick_time", 1800)
	self:AddDTVar("integer (0 to 1800)", "warn_time", 1800)
end

Shine:RegisterExtension("afkdetector", Plugin)
