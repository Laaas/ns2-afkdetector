
function Plugin:Initialise()
	self:SetupDataTable()
	self.dt.kick_time         = self.Config.KickTime
	self.dt.warn_time         = self.Config.WarningTime
	self.dt.playing_kick_time = self.Config.PlayingKickTime
	self.dt.max_players       = self.Config.MaxTeamPlayers

	self.Enabled = true
	return true
end
