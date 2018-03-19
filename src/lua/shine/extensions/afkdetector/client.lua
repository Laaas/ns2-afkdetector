local Plugin = Plugin
local last_active_time = Shared.GetTime()
local warned           = false

function Plugin:Initialise()
	last_active_time = Shared.GetTime()

	self:SetupDataTable()

	self:CreateTimer("CheckAFK", 0.1, -1, function() self:CheckAFK() end)

	self.Enabled = true
	return true
end

function Plugin:PlayingKick()
	Shared.ConsoleCommand "rr"
end

function Plugin:Kick()
	Shared.ConsoleCommand "disconnect"
end

function Plugin:Warn(time)
	Shine.AddChatText(255, 128, 0, "[AFK]", 1, 1, 0.2, string.format("Warning! You will be kicked in %i seconds", time - self.dt.warn_time));
	warned = true
end

function Plugin:CheckAFK()
	local diff = Shared.GetTime() - last_active_time
	local team = Client.GetLocalPlayer():GetTeamNumber()

	local max_players = self.max_players
	if not max_players then -- We cache this because apparently getting perf data is not fast
		local data = Shared.GetServerPerformanceData()
		if not data then return end
		max_players = data:GetMaxPlayers()
		self.max_players = max_players
	end

	if team == 1 or team == 2 then
		if diff > self.dt.playing_kick_time then
			self:PlayingKick()
		elseif not warned and diff > self.dt.warn_time then
			self:Warn(self.dt.playing_kick_time)
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
		if playercount < self.dt.max_players and GetGameInfoEntity():GetNumPlayers() == max_players then
			if diff > self.dt.kick_time then
				self:Kick()
			elseif not warned and diff > self.dt.warn_time then
				self:Warn(self.dt.kick_time)
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
