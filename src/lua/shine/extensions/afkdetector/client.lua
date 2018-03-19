local Plugin = Plugin
local last_active_time = Shared.GetTime()
local warned           = false

function Plugin:Initialise()
	last_active_time = Shared.GetTime()

	self:SetupDataTable()

	self.Enabled = true
	return true
end

function Plugin:PlayingKick()
	Shared.ConsoleCommand "rr"
end

function Plugin:Kick()
	Shared.ConsoleCommand "disconnect"
end

function Plugin:Warn()
	Shine.AddChatText(50, 30, 0, "[AFK]", 1, 1, 0, string.format("Warning! You will be kicked in %i seconds", self.dt.kick_time - self.dt.warn_time));
	warned = true
end

function Plugin:Think()
	local diff = (Shared.GetTime() - last_active_time)
	local team = Client.GetLocalPlayer():GetTeamNumber()

	if team == 1 or team == 2 then
		if diff > self.dt.playing_kick_time then
			self:PlayingKick()
		elseif not warned and diff > self.dt.warn_time then
			self:Warn()
		end
	else
		local playercount = 0
		local teaminfos = GetEntities "TeamInfo"
		for _, info in ipairs(teaminfos) do
			if info:GetTeamNumber() == 1 or info:GetTeamNumber() == 2 then
				playercount = playercount + info:GetPlayerCount()
			end
		end

		-- if more players can join the playing teams, but server is full
		if playercount < self.dt.max_players and Client.GetServerNumPlayers() == Client.GetServerMaxPlayers() then
			if diff > self.dt.kick_time then
				self:Kick()
			elseif not warned and diff > self.dt.warn_time then
				self:Warn()
			end
		else
			last_active_time = Shared.GetTime()
		end
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
