local Plugin = {
	Version = "1.0",
	HasConfig = true,
	ConfigName = "AFKDetector.json",
	DefaultConfig = {
		KickTime        = 300,
		WarnTime        = 150,
		PlayingKickTime = 200,
		MaxTeamPlayers  = 42,
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
	self:AddDTVar("integer (0 to 2048)", "kick_time",         2048)
	self:AddDTVar("integer (0 to 2048)", "warn_time",         2048)
	self:AddDTVar("integer (0 to 2048)", "playing_kick_time", 2048)
	self:AddDTVar("integer (0 to 255)",  "max_players",       0)
end

Shine:RegisterExtension("afkdetector", Plugin)
