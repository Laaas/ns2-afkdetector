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

function Plugin:Think()
	local diff = (Shared.GetTime() - last_active_time)
	if Client.GetLocalPlayer():GetTeamNumber() == kSpectatorIndex then
		diff = diff / self.dt.spec_mult
	end
	if warned and diff > self.dt.kick_time then
		self:Kick()
	elseif diff > self.dt.warn_time then
		self:Warn()
		warned = true
		last_active_time = Shared.GetTime()
	end
end

local old
local function OnSendKeyEvent(key, down, amount, repeated)
	if not repeated then
		last_active_time = Shared.GetTime()
		warned           = false
	end
	old(key, down, amount, repeated)
end

Event.Hook("SendKeyEvent", OnSendKeyEvent)

local old_hook = Event.Hook
function Event.Hook(t, f, ...)
	if t == "SendKeyEvent" then
		old = f
	else
		return old_hook(t, f, ...)
	end
end
