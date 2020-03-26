--[[
Filename: sv_PIPE_init.lua
Purpose: Core Files. Connects every module and performs IP Checks
Note: You aren't supposed to change anything in here unless you know what to do!
]]--
PIPE = PIPE or {}
PIPE.Core = PIPE.Core or {}
PIPE.Util = PIPE.Util or {}
PIPE.Config = PIPE.Config or {}
PIPE.Whitelist = PIPE.Whitelist or {}

include( "pipe/sv_config.lua" )
include( "pipe/sv_messagehandler.lua" )


function PIPE.Core.CheckIP( steamID64, ipAddress, svPassword, clPassword, name )
	local clientIp = string.Explode(":", ipAddress)[1] --Client IP

	http.Fetch( PIPE.Util.FormatRestURL(PIPE.Config["IPServer"], clientIp, PIPE.Config["apiKey"]) ,
		function( body, len, headers, code )
			local content = util.JSONToTable(body)

			if content != nil then
				local cc = content.countryCode or content.country_code or "ZZ"
				local ipScore = content.fraud_score or 0
				local asn = content.ASN or "??"
				ServerLog("[PIPE] SCAN of " .. name .. " CC=" .. cc .. " SCORE=" .. ipScore .. " AS" .. asn .. "\n")


				if !table.HasValue( PIPE.Whitelist["_steamID"], util.SteamIDFrom64( steamID64 ) ) then --badip check
					if cc == "ZZ" and PIPE.Config["KickBadIP"] == true then
						game.KickID(util.SteamIDFrom64( steamID64 ), PIPE.Util.FormatKickMessage(PIPE.Config["MSG_InvalidIP"], name, cc, ipAddress, steamID64) )
					end



					local kickPlayer = false
					local kickMessageType = "MSG_InvalidIP"

					if PIPE.Config["ReverseWhitelist"] then
						kickPlayer = table.HasValue( PIPE.Whitelist["_countryCode"], cc )
						kickMessageType = "MSG_InvalidCC"
					end  -- if blacklist

					if not PIPE.Config["ReverseWhitelist"] then
						kickPlayer = !table.HasValue( PIPE.Whitelist["_countryCode"], cc )
						kickMessageType = "MSG_InvalidCC"
					end -- if whitelist

					if !table.HasValue( PIPE.Whitelist["_ASN"], asn ) then
						if ipScore >= PIPE.Config["IPScoreMax"] then
							kickPlayer = true
							kickMessageType = "MSG_InvalidIPScore"
						end
					end

					if kickPlayer then
						game.KickID(util.SteamIDFrom64( steamID64 ), PIPE.Util.FormatKickMessage(PIPE.Config[kickMessageType], name, cc, ipAddress, steamID64) )
					end
				end
			else
				MsgC( Color( 255, 0, 0 ), "[PIPE] FATAL ERROR: Server: (" .. PIPE.Config["IPServer"] .. ") sent invalid data. Source: " .. PIPE.Util.FormatRestURL(PIPE.Config["IPServer"], clientIp .. "\n"))
			end
		end,
		function( error )
			MsgC( Color( 255, 0, 0 ), "[PIPE] FATAL ERROR: Connection to IP-Api (" .. PIPE.Config["IPServer"] .. ") failed \n")
		end)
end
MsgC( Color( 255, 0, 0 ), "--------------------\n")
MsgC( Color( 255, 0, 0 ), "[PIPE] STARTING UP !\n")
hook.Add( "CheckPassword", "PIPE_getip", PIPE.Core.CheckIP )
MsgC( Color( 255, 0, 0 ), "[PIPE]      OK      \n")
MsgC( Color( 255, 0, 0 ), "--------------------\n")
