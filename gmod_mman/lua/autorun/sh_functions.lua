-- 					mman func start			--
mman = {}

if SERVER then
	function mman:sendrefresh()
		http.Post("https://32a6-185-252-220-156.ngrok-free.app/gmod/refresh.php", {},

			function( body, length, headers, code) 
				print("index.html refreshed");
			end,

			function( message )
				print("error: " .. message)
			end
		)
	end

	-- 					mman func end			--

	-- 					server func	start			--

	function mman:serverrestart()
		mman:sendrefresh()
		timer.Simple(3, function()
			RunConsoleCommand("ulx", "maprestart")
		end)
	end

	function mman:serverstop()
		mman:sendrefresh()
		RunConsoleCommand("sv_password", "shutdown");

		for key, player in pairs(player.GetAll()) do 
			player:ChatPrint("kick")
			player:Kick("Server shutting down...")
		end

		timer.Simple(3, function()
			mman:changemap('')
		end)
	end

	function mman:changepassword(password)
		RunConsoleCommand("sv_password", password)
	end

	function mman:changehostname(hostname)
		mman:sendrefresh()
		RunConsoleCommand("hostname", hostname)
	end

	function mman:changemap(map)
		mman:sendrefresh()
		timer.Simple(3, function ()
			RunConsoleCommand("map", map)
		end)
	end


	function mman:executecommand(command)
		local splited = string.Split(command, " ");
		
		mman:sendrefresh()
		timer.Simple(1, function()
			RunConsoleCommand(splited[1], splited[2])
		end)
	end

	function mman:kickall()
		for key, player in pairs(player.GetAll()) do
			player:Kick("Kicked by server.");
		end
	end

	function mman:printall(text)
		for key, player in pairs(player.GetAll()) do
			player:ChatPrint(text);
		end
	end

	-- 					server func end					--

	-- 					action func	start			--

	function mman:freeze(steamid)
		local ply = player.GetBySteamID64(steamid)
		ply:Freeze(true)
		ply:ChatPrint("You are frozen now.")
	end

	function mman:kill(steamid)
		local ply = player.GetBySteamID64(steamid)		
		ply:Kill()
	end

	function mman:kick(steamid)
		local ply = player.GetBySteamID64(steamid)		
		ply:Kick()
	end

	function mman:ban(steamid)
		local ply = player.GetBySteamID64(steamid)		
		ply:Ban(0)
	end	

	function mman:burn(steamid)
		local ply = player.GetBySteamID64(steamid)		
		ply:Ignite(30)
	end		

	function mman:strip(steamid)
		local ply = player.GetBySteamID64(steamid)		
		ply:StripWeapons()
	end				
	-- 					actions func end			--
end
