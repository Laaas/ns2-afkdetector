
function Plugin:Initialise()
	self:SetupDataTable()
	self.dt.kick_time = self.Config.KickTime - self.Config.WarnTime
	self.dt.warn_time = self.Config.WarnTime
end
