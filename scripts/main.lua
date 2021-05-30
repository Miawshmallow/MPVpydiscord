local options = require 'mp.options'
local msg = require 'mp.msg'
local o = {
	pfile = "presence.py",
	periodic_timer = 14,
	active = "yes",

}

-- set `startTime`
local startTime = os.time(os.date("*t"))
local function main()
	-- set `details`
	local details = mp.get_property("media-title")
	local metadataTitle = mp.get_property_native("metadata/by-key/Title")
	local metadataArtist = mp.get_property_native("metadata/by-key/Artist")
	if metadataTitle ~= nil then
		details = metadataTitle
	end
	if metadataArtist ~= nil then
		details = ("%s\nde: %s"):format(details, metadataArtist)
	end
	if details == nil then
		details = "No file"
	end
	local state, smallImageKey, smallImageText
	local idle = mp.get_property_bool("idle-active")
	local coreIdle = mp.get_property_bool("core-idle")
	local pausedFC = mp.get_property_bool("paused-for-cache")
	local pause = mp.get_property_bool("pause")
	local play = coreIdle and false or true
	if pause then
		state = ""
		smallImageText = "Paused"
		smallImageKey = "pause"
	elseif play then
		state = "ouvindo"
		smallImageKey = "play"
		smallImageText = "Playing "
	end
	-- set time
	local timeNow = os.time(os.date("*t"))
	local timeRemaining = os.time(os.date("*t", mp.get_property("playtime-remaining")))
	-- set `largeImageKey` and `largeImageText`
	local largeImageKey = "mpv"
	local largeImageText = "mpsyt"

	-- streaming mode
	local url = mp.get_property("path")
	local stream = mp.get_property("stream-path")
	-- set `presence`
	local presence = {
		state = state,
		details = details,
		largeImageKey = largeImageKey,
		largeImageText = largeImageText,
		smallImageKey = smallImageKey,
		smallImageText = smallImageText,
	}
	if url ~= nil and stream == nil then
		presence.state = "(Loading)"
		presence.startTimestamp = math.floor(startTime)
		presence.endTimestamp = nil
	end
	-- run Rich Presence
		local pythonPath
		local lib
		pythonPath = mp.command_native({"expand-path", "~~/scripts"}) .. "/py/" .. o.pfile
		local command = ('python "%s"  "%s" "%s" "%s" "%s" "%s" "%s" "%s" '):format(pythonPath, presence.state, presence.details,presence.largeImageKey, presence.largeImageText, presence.smallImageKey, presence.smallImageText, o.periodic_timer)
		if o.active == "yes" then
			io.popen(command)
		end
	end
mp.add_periodic_timer(o.periodic_timer, main)
