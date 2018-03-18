
function Plugin:Initialise()
	self:SetupDataTable()
	self.dt.kick_time = self.Config.KickTime - self.Config.WarningTime
	self.dt.warn_time = self.Config.WarningTime
	local mult = self.Config.SpecMult
	if mult == 0 then
		mult = 1/0
	end
	self.dt.spec_mult = mult

	self.Enabled = true
	return true
end
