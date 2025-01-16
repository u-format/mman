
local function sendtophp()
	local pdata = {}
	for key, player in pairs(player.GetAll()) do
		local p = {
			name = player:Name(),
			steamid = player:SteamID64()
		}
		table.insert(pdata, p)
	end

	local uptime = math.Round((CurTime() / 60)) -- as minutes

	local status = {
		["ip"] = game.GetIPAddress(),
		["hostname"] = GetHostName(),
		["gamemode"] = engine.ActiveGamemode(),
		["map"] = game.GetMap(),
		["players"] = util.TableToJSON(pdata),
		["uptime"] = uptime
	}

	http.Post("https://32a6-185-252-220-156.ngrok-free.app/gmod/test.php", {p = util.TableToJSON(status), a = "test"},

		function( body, length, headers, code) 
			print("done!");
		end,

		function( message )
			print("error: " .. message)
		end
	)
end

local function checkcommand(data)

	if (data == "") then return end

	local command = string.Split(data, ":");
	local mode, argument = command[1], command[2]

	if (mode == "print") then
		ply:ChatPrint(argument)
	elseif (mode  == "printall") then
		mman:printall(argument)
	elseif (mode  == "create") then
		
	elseif (mode == "changemap") then
		mman:changemap(argument)
	elseif (mode == "restart") then
		mman:serverrestart()
	elseif (mode == "stop") then
		mman:serverstop()
	elseif (mode == "changehostname") then
		mman:changehostname(argument)
	elseif (mode == "kickall") then
		mman:kickall()
	elseif (mode == "changepassword") then
		mman:changepassword(argument)
	elseif (mode == "command") then
		mman:executecommand(argument)
	
	-- actions
	elseif (mode == "freeze") then
		mman:freeze(argument)
	elseif (mode == "kill") then
		mman:kill(argument)
	elseif (mode == "kick") then
		mman:kick(argument)
	elseif (mode == "ban") then
		mman:ban(argument)
	elseif (mode == "burn") then
		mman:burn(argument)
	elseif (mode == "strip") then
		mman:strip(argument)
	end
	mman:sendrefresh()
end


timer.Create("merhaba", 5, 0 , function ()	
	http.Fetch("https://32a6-185-252-220-156.ngrok-free.app/gmod/", 

		function ( body, length, headers, code )
			checkcommand(body)
		end,

		function(message)
			print("error: " .. message)
		end,

		{ 
			 
		} -- empty headers :yum:
	)
end)


timer.Create("statusRefresh", 10, 0, function()
	sendtophp()
	print("status.html refresh")
end)