local Plugin = Plugin
local last_active_time = Shared.GetTime()
local warned           = false

function Plugin:Initialise()
	last_active_time = Shared.GetTime()

	self:SetupDataTable()

	self.Enabled = true
	return true
end

function Plugin:Kick()
	Shared.ConsoleCommand "disconnect"
end

function Plugin:Warn()
	Shine.AddChatText(50, 30, 0, "[AFK]", 1, 1, 0, string.format("Warning! You will be kicked in %i seconds", self.dt.kick_time));
end

function Plugin:OnThink()
	local diff = (Shared.GetTime() - last_active_time) / self.dt.spec_mult
	if warn and diff > self.dt.kick_time then
		self:Kick()
	elseif diff > self.dt._warn_time then
		self:Warn()
		warn = true
	end
end

local function OnSendKeyEvent(key, down, amount, repeated)
	if not repeated then
		last_active_time = Shared.GetTime()
		warned           = false
	end
end

Event.Hook("SendKeyEvent", OnSendKeyEvent)
