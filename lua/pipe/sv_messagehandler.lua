--[[
Filename: sv_messagehandler.lua
Purpose: Formats Messages
Note: You aren't supposed to change anything in here unless you know what to do!
]]--

PIPE = PIPE or {}
PIPE.Util = PIPE.Util or {}

function PIPE.Util.FormatKickMessage(msg, name, cc, ip, sid) -- QuickFormats
	msg = string.Replace( msg, "$PLAYER_NAME", name )
	msg = string.Replace( msg, "$IP", string.Explode(":", ip)[1] )
	msg = string.Replace( msg, "$COUNTRY_CODE", cc or "ZZ" )
	msg = string.Replace( msg, "$CC", cc or "ZZ" )
	msg = string.Replace( msg, "$STEAMID", util.SteamIDFrom64(sid) )
	msg = string.Replace( msg, "$CONTACT", PIPE.Config["Contact"])
	return msg
end

function PIPE.Util.FormatRestURL(url, ip, key)
	url = string.Replace(PIPE.Util.FormatIPServer(url), "$IP", ip)
	url = string.Replace(url, "$apiKey", key)
	return url
end

function PIPE.Util.FormatIPServer(url)
	if url == "ipqualityscore.com" then return "https://www.ipqualityscore.com/api/json/ip/$apiKey/$IP" end
	if url == "donovanclan.de" then return "https://www.donovanclan.de/IPGB/index.php/rest/geoip/resolve/$IP" end
	if url == "ip-api.com" then return "http://ip-api.com/json/$IP" end
	if url == "momoxstudios.net" then return "https://momoxstudios.net/IPGB/index.php/rest/geoip/resolve/$IP" end
	return url
end
