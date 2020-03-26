--[[
Filename: sv_config.lua
Purpose: Config obviously
]]--

PIPE = PIPE or {}
PIPE.Config = PIPE.Config or {}
PIPE.Whitelist = PIPE.Whitelist or {}

-- Do not touch anything above this line

--###################################################
--##################### Config ######################
--###################################################

-- IP-Server | Define the Server being used to trace IPS down ( GeoIP Service ) PIPE comes with 2 free/unlimited IP Servers.
PIPE.Config["IPServer"] = "ipqualityscore.com" -- Valid options: "ip-api.com" or "ipqualityscore.com" or "momoxstudios.net" 

-- if you use ipqualityscore.com you will need a API key, so create an account on theirs website to get a apikey 
PIPE.Config["apiKey"] = "YOUR-API-KEY-HERE"

-- Define the maximum IP fraud score value authorised. If the IP TESTED has a score upper than this value the player will be kicked
PIPE.Config["IPScoreMax"] = 75

-- Kick Bad IPs | Kick IPs wich can't be traced down (Mostly local IP's)
PIPE.Config["KickBadIP"] = true -- Valid options: true / false

-- Reverse Whitelist | Reverse the Country Whitelist, so only Countries inside can't join the server
PIPE.Config["ReverseWhitelist"] = false -- Valid options: true / false

-- Kick Message CC | The kick message people get when being kicked for not being whitelisted (Use \n to make a new line)
-- Available Quick Codes: $PLAYER_NAME; $IP; $COUNTRY_CODE or $CC; $STEAMID; $CONTACT
PIPE.Config["MSG_InvalidCC"] = "\n[PIPE] You have been kicked!\nYour Country ($CC) is not allowed on this server\nIf you believe this is an error, contact:\n$CONTACT"

-- Kick Message IP | The kick message people get when being kicked for having an invalid IP (Use \n to make a new line)
-- Available Quick Codes: $PLAYER_NAME; $IP; $COUNTRY_CODE or $CC; $STEAMID; $CONTACT
PIPE.Config["MSG_InvalidIP"] = "\n[PIPE] You have been kicked!\nYour IP ($IP) is invalid!\nIf you believe this is an error, contact:\n$CONTACT"

-- Kick Message SCORE | The kick message people get when being kicked for not being whitelisted (Use \n to make a new line)
-- Available Quick Codes: $PLAYER_NAME; $IP; $COUNTRY_CODE or $CC; $STEAMID; $CONTACT
PIPE.Config["MSG_InvalidIPScore"] = "\n[PIPE] You have been kicked!\nYour IP is not allowed on this server because it's a Proxy, VPN or used by fraudsters\nIf you believe this is an error, contact:\n$CONTACT"

-- Contact | Define the $CONTACT parameter for kick messages. Enter your Steam Profile, Website/Forum or whatever
PIPE.Config["Contact"] = "ADMIN-CONTACT-HERE"

--###################################################
--#################### Whitelist ####################
--###################################################

-- Country Code Whitelist | Add countries which should be whitelisted in this table. A list can be found here (the Alpha 2 codes): http://www.nationsonline.org/oneworld/country_code_list.htm | ZZ means invalid
PIPE.Whitelist["_countryCode"] = {"BE", "FR", "CA", "CH", "RE"} -- Has to look like this;  No Country: {} | One Country: {"DE"} | Multiple Countries: {"DE","FR","IT"}        DONT FORGET THE "" 

-- ISP Whitelist | ADD the AS Number of ISP which should bypass IP reputation check
PIPE.Whitelist["_ASN"] = {"3215", "12322", "5410", "8228", "15557", "51207"}

-- SteamID Whitelist | Add SteamID's which should bypass all checks.
PIPE.Whitelist["_steamID"] = {"STEAM_0:0:00000000"} -- Has to look like this;  No SteamID: {} | One SteamID: {"STEAM_0:1:76836829"} | Multiple Countries: {"STEAM_0:1:76836829","STEAM_0:1:23456789"}        DONT FORGET THE "" 
